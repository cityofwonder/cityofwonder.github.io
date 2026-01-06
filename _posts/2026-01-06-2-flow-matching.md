---
layout: post
title: "[STAT433 01.] Flow Matching 기반 생성 모델과 Causal Discovery"
subtitle: "OT-CFM을 활용한 분포 학습, DiffAN, OOD Detection"
categories: ["📂/school"]
tags: ["deep_learning", "flow_matching", "causal_inference", "generative_model"]
banner:
  image: "/assets/images/2026-01-06/header-sub71.png"
  opacity: 0.4
  background: "rgba(0, 0, 0, 0.7)"
---

## 0. 📍 개요

### 프로젝트 목표

Generative Model과 Causal Inference의 교차점 탐구. Flow Matching을 구현하여 고차원 tabular 데이터의 분포를 학습하고, 이를 활용해 causal structure 발견 및 OOD detection 수행.

### 데이터셋

| 항목 | 내용 |
| --- | --- |
| 형식 | `train_29.npy`, `test_29.npy` |
| 차원 | 100차원 (Tabular) |
| Train | 8,000 샘플 (ID only) |
| Test | 2,200 샘플 (ID 2,000 + OOD 200) |

### 필수 요구사항

| Problem | Task | Method | Evaluation |
| --- | --- | --- | --- |
| 1 (20pt) | Generative Modeling | Flow Matching or Score-based | MMD Score |
| 2 (20pt) | Causal Discovery | DiffAN (Jacobian of Score) | Topological Order 정확도 |
| 3 (20pt) | OOD Detection | Instantaneous Change of Variable | AUROC |

### 제약사항

- MLP + Time Embedding 사용 (CNN/U-Net 금지)
- Topological Order 형식: `[x10, x3, x1, ..., x99]` (Root → Leaf)
- OOD 분류: ID(0), OOD(1)

### 💡 Result Summary ⭐

| Problem | Output | Score/Result |
| --- | --- | --- |
| 1 | `generated_samples.npy` (2,200개) | MMD = **0.007190** |
| 2 | Topological Order | `[x28, x29, x26, ..., x51]` (100개) |
| 3 | OOD Detection | Threshold = **-245.93**, 200/2200 detected |

---

## 1. 🔧 Methodology

### 1-1. Model Selection: **Flow Matching**

우선 데이터를 확인하면 다음과 같다.

```python
Train: (8000, 100), dtype: float64
Test: (2200, 100), dtype: float64
Train mean: 0.0626, std: 1.5975
Test mean: 0.0570, std: 3.8493
```

100차원 tabular 데이터인데, test의 std가 train보다 2배 이상 컸다. 즉, **OOD 샘플 200개가 분포를 벌려놓은 것으로 추정. 이미지가 아니라 연속형 수치 데이터이므로 spatial structure가 없음 → CNN/U-Net 쓸 이유 없고, MLP 기반이 적합.**

이라고 판단했다.

그럼 **Flow Matching vs Score-based** 중 뭘 써야할까? 나는 아래 이유로 Flow Matching을 선택했다.

1. **학습 안정성**: Score-based는 noise schedule 튜닝이 까다롭고 score explosion 문제가 있음. Flow Matching은 단순 MSE regression이라 안정적.
2. **샘플링 효율**: Score-based SDE는 수백 step 필요한데, Flow Matching ODE는 50-100 step이면 충분.
3. **Problem 3 호환성**: OOD Detection에서 Instantaneous Change of Variable Formula를 쓰라고 명시됨. 이건 Flow Matching의 log-likelihood 계산 방식이라 사실상 Flow Matching 강제.

세 번째가 결정적이라 Problem 3까지 고려하면 Flow Matching을 선택한 것이다.

### 1-2. Model Architecture: **ResNet-style skip connection을 넣은 MLP**

MLP + Time Embedding 제약이 있어서 CNN/U-Net은 못 쓴다. 따라서 이를 대신하여 **ResNet-style skip connection을 넣은 MLP를 설계**했다.

```
Input(x, t) → SinusoidalTimeEmb(t) → InputProj(x) → ResBlock x6 → OutputProj → Velocity
```

처음에 ***hidden_dim=256, blocks=4로 시작했는데, loss가 1.6 근처에서 수렴하고 더 안 내려갔다.***

뭐가 문제일지 고민해봤는데, 아래 후보군이 있었다.

1. **모델 capacity 부족**: 100차원 데이터의 복잡한 분포를 학습하기엔 네트워크가 너무 작음
2. **학습 불안정**: gradient vanishing으로 깊은 layer까지 학습이 안 됨

1번이 유력해 보여서 모델을 키워봤다. hidden_dim=512, blocks=6으로 올리니까 loss가 1.39까지 떨어지는 효과를 볼 수 있었다..

그럼 더 키우면 더 좋아질까? hidden_dim=768, blocks=8, epoch=1000으로 시행해봤지만 이 경우 overfitting이었다. (train loss는 더 낮아졌지만 test 기준 MMD는 올라감)

| Config | Hidden | Blocks | Epochs | Final Loss | MMD |
| --- | --- | --- | --- | --- | --- |
| Small | 256 | 4 | 500 | ~1.60 | 측정 안함 |
| Medium | 512 | 6 | 500 | 1.39 | **0.007** |
| Large | 768 | 8 | 1000 | 1.35 | 0.021 |

**결론적으로 Medium config (512/6/500)가 최적이었다.**

> **최종 구조:**
> 
> - Hidden dim: 512
> - Num blocks: 6
> - Time embedding: 128-dim Sinusoidal
> - Activation: SiLU
> - Normalization: LayerNorm (각 ResBlock 내부)

### 1-3. Training Details

**Loss Function (Optimal Transport Conditional Flow Matching):**

Flow Matching의 핵심 아이디어는 단순하다**. noise 분포 $x_0 \sim \mathcal{N}(0, I)$에서 data 분포 $x_1 \sim p_{data}$로 가는 경로를 학습**하는 것이다.

이때 두 점 사이를 직선으로 연결하는 linear interpolation을 사용한다:

$x_t = (1-t)x_0 + tx_1$

$t=0$일 때는 순수 noise이고, $t=1$일 때는 실제 데이터가 된다. 그리고 이 직선 경로를 따라 이동하는 velocity는 단순히 두 점의 차이가 된다:

$u_t = x_1 - x_0$

모델이 학습해야 할 것은 바로 이 **velocity를 예측하는 것**이다. 따라서 loss function은 예측한 velocity $v_\theta(x_t, t)$와 실제 velocity $u_t$ 사이의 MSE가 된다

$\mathcal{L} = \mathbb{E}{t, x_0, x_1} \left[ \| v\theta(x_t, t) - (x_1 - x_0) \|^2 \right]$

직관적으로 해석하면, 모델에게 "현재 시점 $t$에서 위치 $x_t$에 있을 때, 데이터 분포를 향해 어느 방향으로 얼마나 움직여야 하는가?"를 가르치는 것이다.

**Hyperparameters:**

| Item | Value | 비고 |
| --- | --- | --- |
| Epochs | 500 | 1000 시도 시 overfitting 발생 |
| Batch size | 256 | - |
| Optimizer | AdamW | lr=1e-3, weight_decay=1e-4 |
| Scheduler | CosineAnnealingLR | eta_min=1e-5 |
| Gradient clipping | 1.0 | 학습 안정화 목적 |

데이터 전처리로는 z-score normalization을 적용했다. train set 기준으로 mean과 std를 계산한 뒤, test set에도 동일한 값을 적용하여 분포를 맞춰주었다.

### 1-4. Sampling Strategy

학습이 완료되면, 모델은 **임의의 위치와 시점에서 ‘데이터를 향한 방향’을 알려줄 수 있게 된다**. 이제 이를 활용해서 실제 샘플을 생성해야 한다.

샘플링은 ODE(Ordinary Differential Equation)를 푸는 과정이다. $t=0$에서 random noise로 시작해서, 학습된 velocity field를 따라 $t=1$까지 이동하면 데이터 분포의 샘플이 된다:

$\frac{dx}{dt} = v_\theta(x, t)$

이 ODE를 수치적으로 풀기 위해 Euler method를 사용했다:

$x_{t+\Delta t} = x_t + v_\theta(x_t, t) \cdot \Delta t$

100 steps로 설정했으므로 $\Delta t = 0.01$이 된다. 매 step마다 현재 위치에서 모델이 예측한 velocity 방향으로 조금씩 이동하면, 최종적으로 데이터 분포에 도달하게 된다.

*➕더 정밀한 RK4(Runge-Kutta 4th order) solver도 시도해보았다. 그러나 MMD 차이는 거의 없었고 (0.007 vs 0.0068), 연산 시간만 약 4배 증가했다.* 

따라서 효율성을 고려하여 **Euler method를 최종 선택**했다.

| Solver | Steps | MMD | Time |
| --- | --- | --- | --- |
| Euler | 100 | 0.007 | ~3s |
| RK4 | 100 | 0.0068 | ~12s |

---

## 2. 📊 Results

### 2-1. Problem 1: Generative Modeling

prob1의 목표는 학습된 **Flow Matching 모델로 2,200개의 샘플을 생성하고, test set과의 MMD(Maximum Mean Discrepancy)를 측정하는 것**이다.

### **MMD란?**

두 분포가 얼마나 다른지를 측정하는 지표이다. 생성된 샘플의 분포와 test 데이터의 분포가 완전히 동일하면 MMD는 0이 된다. 값이 작을수록 생성 품질이 좋다는 의미이다.

계산 방식은 RBF(Radial Basis Function) kernel을 사용한다. 두 분포에서 샘플 쌍들 간의 유사도를 kernel로 측정한 뒤, 분포 내부의 유사도와 분포 간 유사도의 차이를 계산한다:

$\text{MMD}^2 = \mathbb{E}[k(x, x')] + \mathbb{E}[k(y, y')] - 2\mathbb{E}[k(x, y)]$

여기서 $x, x'$는 생성 샘플, $y, y'$는 test 샘플이다.

결과는 아래와 같았다.

| Metric | Value |
| --- | --- |
| Generated samples | 2,200개 |
| MMD Score | **0.007190** |
| Final training loss | 1.39 |

MMD 0.007은 상당히 양호한 수치이다. 일반적으로 0.01 이하면 좋은 품질로 평가되며, 0.001 이하면 매우 우수한 것으로 간주된다.

아래 그래프들은 생성된 샘플이 원본 데이터의 분포를 얼마나 잘 복원했는지를 보여준다.

<figure style="text-align: center;">
    <img src="/assets/images/2026-01-06/probblem1_evalutation.png" alt="Problem 1: Generative Modeling 평가 결과">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">Problem 1: Generative Modeling 평가 결과</figcaption>
</figure>

왼쪽 상단의 Training Loss Curve를 보면, **loss가 500 epoch 동안 꾸준히 감소하여 약 1.39에서 수렴한 것을 확인할 수 있다**. 오른쪽 상단의 Distribution Comparison은 처음 5개 dimension에 대해 train 데이터와 생성 데이터의 히스토그램을 겹쳐 그린 것인데, **두 분포가 상당히 유사하게 매칭**되는 것을 볼 수 있다.

하단의 Per-dimension Mean/Std Comparison 그래프에서는 각 dimension별 평균과 **표준편차를 비교**했다. 점들이 대각선(y=x) 위에 몰려 있을수록 생성 분포가 원본과 일치한다는 의미인데, 대부분의 점들이 **대각선 근처에 위치하고 있어 모델이 100차원 전체에 걸쳐 분포를 잘 학습**했음을 알 수 있다.

### 2-2. Problem 2: Causal Discovery

prob2의 목표는 **DiffAN 알고리즘을 사용하여 100개 변수의 causal graph에서 topological order를 도출하는 것**이다.

### **DiffAN이란?**

Score function의 Jacobian을 분석하여 인과 관계를 추론하는 알고리즘이다. 핵심 아이디어는 다음과 같다:

Causal graph에서 **root 변수(원인)**는 다른 변수에 의존하지 않는다. 따라서 score function을 해당 변수로 미분했을 때, 다른 변수들에 대한 영향이 적다. 반대로 **leaf 변수(결과)**는 여러 변수의 영향을 받으므로 Jacobian의 variance가 크다.

이를 수식으로 표현하면, score function $s_\theta(x)$의 Jacobian matrix $J$에서 각 열(column)의 variance를 계산한다:

$\text{Var}j = \text{Var}{x}\left[\frac{\partial s_\theta(x)}{\partial x_j}\right]$

variance가 가장 낮은 변수가 root이다. 이 변수를 topological order의 맨 앞에 배치하고, 해당 변수를 제거한 뒤 다시 variance를 계산하는 과정을 반복하면 전체 순서를 얻을 수 있다.

Flow Matching에서는 score function 대신 velocity field의 Jacobian을 사용한다. $t=0.1$ 시점에서 500개 샘플에 대해 Jacobian을 계산하고, 각 변수별 variance를 측정했다. 가장 낮은 variance를 가진 변수를 선택하고 제거하는 과정을 100번 반복하여 전체 topological order를 도출했다.

결과는 아래와같았다.

```
[x28, x29, x26, x15, x12, x64, x84, x82, x61, x40, x27, x43, x3, x68, x87, x44, x74, x75, x90, x37, x56, x85, x96, x9, x33, x13, x25, x20, x66, x42, x89, x53, x54, x39, x98, x4, x71, x23, x63, x69, x36, x8, x7, x2, x79, x62, x22, x48, x76, x88, x50, x11, x77, x1, x83, x78, x67, x60, x32, x58, x49, x24, x10, x19, x45, x41, x35, x16, x81, x47, x5, x86, x55, x6, x18, x0, x80, x17, x34, x52, x65, x57, x31, x93, x70, x14, x30, x46, x21, x95, x73, x94, x97, x91, x99, x38, x72, x92, x59, x51]

```

x28이 root(원인), x51이 leaf(결과)로 도출되었다.

<figure style="text-align: center;">
    <img src="/assets/images/2026-01-06/problem2_causal_discovery.png" alt="Problem 2: Causal Discovery 결과">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">Problem 2: Causal Discovery 결과</figcaption>
</figure>

왼쪽 그래프는 **selection order에 따른 variance 변화**를 보여준다. **앞쪽에서 선택된 변수(root에 가까운 변수)일수록 variance가 낮고, 뒤로 갈수록 variance가 증가하는 패턴이 명확하게 나타난다.** 이는 DiffAN 알고리즘이 의도한 대로 작동하고 있음을 보여준다.

variance 범위는 약 0.00025에서 0.00035 사이로, root 변수(x28)의 variance가 0.000250인 반면 leaf 변수(x51)는 0.000353으로 약 1.4배 차이가 난다. 차이가 크지 않아 보일 수 있지만, 100개 변수를 순차적으로 분리해내기에는 충분한 신호였다.

### 2-3. Problem 3: OOD Detection

prob3에선 test set 2,200개 중 숨겨진 200개의 OOD(Out-of-Distribution) 샘플을 탐지한다.

이는 **Instantaneous Change of Variable Formula**로 달성할 수 있다. ****Flow Matching의 장점 중 하나는 exact log-likelihood를 계산할 수 있다는 것이다. 이를 통해 각 샘플이 학습된 분포에 얼마나 적합한지를 정량적으로 측정할 수 있다.

log-likelihood 계산은 다음과 같이 이루어진다. 데이터 $x_1$에서 시작해서 ODE를 역방향으로 풀어 noise $x_0$를 얻는다. 이 과정에서 Jacobian의 trace(divergence)를 적분하면 확률 변환에 따른 보정항을 얻을 수 있다:

$\log p(x_1) = \log p(x_0) - \int_0^1 \nabla \cdot v_\theta(x_t, t) \, dt$

여기서 $\log p(x_0)$는 표준 정규분포의 log-likelihood이고, 적분항은 flow를 따라 확률이 어떻게 변하는지를 나타낸다.

ID(In-Distribution) 샘플은 학습된 분포에 적합하므로 높은 log-likelihood를 가진다. 반면 OOD 샘플은 학습된 분포에서 벗어났으므로 낮은 log-likelihood를 가진다. 따라서 적절한 threshold를 설정하면 둘을 분리할 수 있다.

결과는 아래와 같았다.

| Metric | Value |
| --- | --- |
| Threshold | -245.93 |
| Predicted OOD | 200/2200 |
| ID log-likelihood 범위 | ~ 0 근처 |
| OOD log-likelihood 범위 | -20,000 ~ -120,000 |

threshold는 하위 9.09% (200/2200)에 해당하는 log-likelihood 값으로 설정했다. **문제에서 OOD가 정확히 200개라고 명시**했기 때문에 이 방식을 사용한 것이다.

<figure style="text-align: center;">
    <img src="/assets/images/2026-01-06/problem3_ood_detection.png" alt="Problem 3: OOD Detection 결과">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">Problem 3: OOD Detection 결과</figcaption>
</figure>

왼쪽 히스토그램을 보면 **ID 샘플과 OOD 샘플이 매우 명확하게 분리**되어 있다. ID 샘플들은 log-likelihood가 0 근처에 밀집해 있고, OOD 샘플들은 -20,000 이하로 크게 떨어져 있다. 두 분포 사이에 거의 겹치는 영역이 없어서 분류가 매우 용이하다.

오른쪽의 sorted log-likelihood 그래프에서도 이 분리가 명확히 드러난다. 약 200번째 샘플 지점에서 급격한 절벽(cliff)이 형성되어 있어, threshold 설정이 매우 robust함을 알 수 있다. 이 정도의 분리도라면 AUROC는 1.0에 가까울 것으로 추정된다.

---

## 3. ✅ Conclusion

본 프로젝트에서는 Flow Matching 기반 생성 모델을 구현하여 세 가지 task를 수행했다.

| Problem | Task | Result |
| --- | --- | --- |
| 1 | Generative Modeling | MMD = **0.007190** |
| 2 | Causal Discovery | Topological Order 100개 도출 |
| 3 | OOD Detection | 200/2200 OOD 탐지, 명확한 분리 |

Problem 1에서는 OT-CFM(Optimal Transport Conditional Flow Matching)을 사용하여 100차원 tabular 데이터의 분포를 성공적으로 학습했다. MMD 0.007은 생성된 샘플이 원본 분포를 잘 복원했음을 나타낸다.

Problem 2에서는 DiffAN 알고리즘을 적용하여 causal graph의 topological order를 도출했다. Jacobian variance가 선택 순서에 따라 점진적으로 증가하는 패턴을 통해 알고리즘이 의도대로 작동했음을 확인할 수 있었다.

Problem 3에서는 Instantaneous Change of Variable Formula를 활용한 exact log-likelihood 계산으로 OOD 샘플을 탐지했다. ID와 OOD 간 log-likelihood 차이가 매우 커서 (0 vs -20,000 이하) 거의 완벽한 분리가 가능했다.

한편, 진행한 프로젝트의 개선방향은 다음과 같이 정리할 수 있을거 같다.

**1. Causal Discovery 검증의 어려움**

Problem 2에서 도출한 topological order의 정확도를 직접 검증할 수 없었다. ground truth가 주어지지 않았기 때문에, Jacobian variance 패턴이 합리적인지만 확인할 수 있었다. 실제 정확도는 채점 시 확인될 것이다.

**2. 모델 튜닝의 한계**

시간 제약으로 인해 제한된 범위의 hyperparameter만 탐색했다. 더 체계적인 grid search나 학습률 스케줄링 전략을 적용했다면 MMD를 추가로 낮출 수 있었을 것이다.

**3. OOD Detection threshold 설정**

현재는 OOD가 정확히 200개라는 사전 정보를 활용하여 threshold를 설정했다. 실제 상황에서는 OOD 비율을 알 수 없으므로, validation set 기반의 threshold 선정 전략이 필요할 것이다.

> **한 학기 수고하셨습니다!** 🐹

<figure style="text-align: center;">
    <img src="/assets/images/2026-01-06/header-sub71.png" alt="축하해! 사이버전실습 A+!">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">축하해! 사이버전실습 A+!</figcaption>
</figure>