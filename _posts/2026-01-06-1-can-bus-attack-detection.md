---
layout: post
title: "[모의사이버전실습 01.] CAN Bus 공격 탐지 모델 개발"
subtitle: "Rule-based + LightGBM 하이브리드 IDS"
categories: ["📂/school"]
tags: ["machine_learning", "CAN_bus", "IDS", "kaggle", "LightGBM", "anomaly_detection", "automotive_security", "feature_engineering"]
banner:
  image: "/assets/images/2026-01-06/header-dt.png"
  opacity: 0.4
  background: "rgba(0, 0, 0, 0.7)"
---

> **한 학기 수고많으셨습니다!! 🐹👏**

<figure style="text-align: center;">
    <img src="/assets/images/2026-01-06/header-dt.png" alt="기말과제 2개 끝나서 수고했어!">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">기말과제 2개 끝나서 수고했어!</figcaption>
</figure> 

## 0. 📍 개요

CAN Bus 네트워크에서 발생하는 공격 메시지를 탐지하는 침입탐지 모델 개발 과정을 정리한 것이다.

### 과제 개요

| 항목 | 내용 |
| --- | --- |
| 플랫폼 | Kaggle (25-2 Subject71) |
| 기간 | 2024.12.10 ~ 12.19 23:55 |
| 목표 | CAN 메시지 공격 여부 이진분류 |
| 평가지표 | F1-Score (상대평가) |
| 제출제한 | 1일 5회 |

### 데이터셋 구성

| 파일 | 크기 | Label | 용도 |
| --- | --- | --- | --- |
| train.csv | 1,338,700 | ❌ (전부 정상) | 정상 패턴 학습 |
| validation.csv | 841,182 | ⭕ | 지도학습 / 검증 |
| test.csv | 5,847,672 | ❌ | 예측 대상 |

### 제출 형식

- **Column**: `index`, `label`
- **Length**: 5,847,672 (전체 test 메시지)
- **Label**: 0(정상), 1(공격)

### 최종 결과 ⭐

| 지표 | 값 |
| --- | --- |
| Public Score | **0.93874** |
| 순위 | **3위** |
| Validation F1 | 0.9702 |

### 평가 기준

**Kaggle 대회 (15점)** - Private Score 기준 상대평가

- 1등~5등: 15점
- 6등~10등: 13점
- 11등~15등: 11점
- 16등 이하: 9점~

**보고서 (15점, PDF, 최대 10페이지)**

| 항목 | 배점 | 세부 |
| --- | --- | --- |
| 전처리 방식 설명 | 5점 | 왜 이렇게 전처리했는지 |
| 모델/알고리즘 선택 이유 | 5점 | 왜 이 모델을 골랐는지 |
| 코드 파트별 설명 | 5점 | 각 파트가 뭘 하는지 |

## 1. 👀 Data Analysis

### 1-1. Dataset Overview

일단 데이터가 어떻게 생겼는지부터 봐보자

```python
import pandas as pd
train = pd.read_csv('train.csv')
val = pd.read_csv('validation.csv')
test = pd.read_csv('test.csv')

print("=== Shape ===")
print(f"train: {train.shape}, val: {val.shape}, test: {test.shape}")
print("\\n=== Columns ===")
print(f"train: {train.columns.tolist()}")
print(f"val: {val.columns.tolist()}")
print(f"test: {test.columns.tolist()}")

```

```
=== Shape ===
train: (1338700, 4), val: (841182, 5), test: (5847672, 4)

=== Columns ===
train: ['Timestamp', 'Arbitration_ID', 'DLC', 'Data']
val: ['Label', 'Timestamp', 'Arbitration_ID', 'DLC', 'Data']
test: ['Timestamp', 'Arbitration_ID', 'DLC', 'Data']

```

train은 Label이 없고 전부 정상 데이터라고 했으니까, 여기서 "정상 패턴"을 뽑아내는 게 핵심이겠다 싶었다. validation은 Label이 있어서 지도학습에 쓸 수 있고, test는 약 580만 개로 양이 꽤 많다.

```python
print("=== Unique Arbitration_ID ===")
print(f"train: {train['Arbitration_ID'].nunique()}")
print(f"val: {val['Arbitration_ID'].nunique()}")
print(f"test: {test['Arbitration_ID'].nunique()}")

```

```
=== Unique Arbitration_ID ===
train: 79
val: 2035
test: 2049

```

근데 여기서 좀 이상한 점이 보였다. train에는 79개의 ID만 있는데, validation이랑 test에는 2000개가 넘는다. 이게 뭔가 싶어서 공격 비율부터 확인해봤다.

```python
print("=== Label Distribution (val) ===")
print(val['Label'].value_counts())
print(f"Attack ratio: {val['Label'].mean():.4f}")

```

```
=== Label Distribution (val) ===
Label
0    659394
1    181788
Attack ratio: 0.2161

```

공격이 약 21.6% 정도 섞여있다. 클래스 불균형이 좀 있긴 한데 심각한 수준은 아니라서, 일단 이 정도면 모델이 충분히 학습할 수 있겠다 싶었다.

### 1-2. Attack Pattern Discovery

이제 본격적으로 "뭐가 공격인지" 패턴을 찾아봤다.

### 1-2-1. DLC 분석

```python
print("=== DLC vs Attack ===")
print(val.groupby('DLC')['Label'].agg(['sum','count','mean']))

```

```
=== DLC vs Attack ===
     sum    count      mean
DLC
0    1172    8189  0.143119
1    1204    1204  1.000000
2    1432    2516  0.569157
3    1161    1161  1.000000
4   16058   70634  0.227341
5    3881   17004  0.228240
6    6717   35594  0.188712
7    6442   33327  0.193297
8  143721  671553  0.214013

```

**DLC=1이랑 DLC=3은 공격 비율이 1.0이다.** 즉 100% 공격이라는 뜻이다. 그리고 train의 DLC 분포를 보면:

```python
print("=== DLC Distribution (train) ===")
print(train['DLC'].value_counts().sort_index())

```

```
=== DLC Distribution ===
DLC
2      2227
4    111899
5     27834
6     58449
7     55666
8   1082625

```

train에는 DLC=1, DLC=3이 아예 없다. 정상 데이터에는 존재하지 않는 DLC 값이 validation에서는 전부 공격으로 나온 거다. 이건 100% 확신할 수 있는 Rule이니까 바로 채택했다.

### 1-2-2. Unknown ID 분석

아까 train에 79개, val에 2035개 ID가 있다고 했는데, 이 차이가 뭔지 궁금했다.

```python
train_ids = set(train['Arbitration_ID'].unique())
val_unknown = val[~val['Arbitration_ID'].isin(train_ids)]

print("=== Unknown ID in Validation ===")
print(f"Total: {len(val_unknown)}")
print(f"Attack ratio: {val_unknown['Label'].mean():.4f}")

```

```
=== Unknown ID in Validation ===
Total: 45477
Attack ratio: 0.8455

```

train에 없는 ID가 validation에 45,477개 있고, 그 중 84.55%가 공격이다. 근데 100%가 아니라 84%라는 게 좀 걸렸다. 나머지 15%는 정상인데 Unknown ID라서 공격으로 찍어버리면 FP(False Positive)가 터진다.

그래서 "Unknown ID인데 정상인 애들"이 뭔지 파봤다.

```python
val_unknown_normal = val_unknown[val_unknown['Label'] == 0]

print("=== Unknown ID but Normal ===")
print(f"Count: {len(val_unknown_normal)}")
print(f"DLC distribution:\\n{val_unknown_normal['DLC'].value_counts()}")
print(f"Top IDs:\\n{val_unknown_normal['Arbitration_ID'].value_counts().head(10)}")

```

```
=== Unknown ID but Normal ===
Count: 7026
DLC distribution:
DLC
0    7017
8       9

Top IDs:
Arbitration_ID
000    7017
6ED       6
79E       3

```

7,026개 중에 7,017개가 **ID='000'이면서 DLC=0**인 경우다. 얘네만 따로 처리해주면 Unknown ID Rule의 정밀도를 확 올릴 수 있겠다 싶었다.

### 🔍 ID='000' 상세 분석

ID='000'이 뭔가 특이해서 더 파봤다.

```python
id_000 = val[val['Arbitration_ID'] == '000']
print(f"Total: {len(id_000)}")
print(f"Label distribution:\\n{id_000['Label'].value_counts()}")
print(id_000.groupby(['DLC', 'Label']).size().unstack(fill_value=0))

```

```
=== ID '000' Analysis ===
Total: 30852

Label distribution:
1    23835
0     7017

By DLC:
Label    0      1
DLC
0     7017      1
4        0      2
5        0      2
8        0  23830

```

결과가 깔끔하게 나왔다.

- **DLC=0이면 99.99% 정상** (7,017개 중 1개만 공격)
- **DLC=8이면 100% 공격** (23,830개 전부)
- DLC=4, 5도 소수지만 전부 공격

이거 보고 바로 Rule을 세웠다:

- `ID='000' + DLC=0` → 정상으로 처리
- `ID='000' + DLC=8` → 공격으로 처리

### 1-2-3. Time Delta 분석

시간 간격도 공격 탐지에 유용할 것 같아서 봤다.

```python
val['time_delta'] = val.groupby('Arbitration_ID')['Timestamp'].diff()

print("=== Normal Time Delta ===")
print(val[val['Label']==0]['time_delta'].describe())
print("\\n=== Attack Time Delta ===")
print(val[val['Label']==1]['time_delta'].describe())

```

```
=== Normal Time Delta ===
count    659318.000000
mean       0.028507
std        0.191965
50%        0.010170

=== Attack Time Delta ===
count    179829.000000
mean       0.117929
std        0.695183
50%        0.005080

```

정상 메시지의 중앙값은 약 0.01초인데, 공격 메시지는 약 0.005초다. **공격이 2배 정도 빠르게 날아온다.** DoS 공격이나 Injection 공격 특성상 빠르게 메시지를 쏟아붓는 패턴이 있어서 그런 것 같다.

이 정보를 Feature로 활용하기로 했다.

### 1-3. Preprocessing Strategy

분석 결과를 종합해서 전처리 전략을 세웠다.

**Rule-based (100% 확신)**

- `DLC=1 or DLC=3` → 공격
- `ID='000' + DLC=8` → 공격
- `ID='000' + DLC=0` → 정상

**ML에 위임 (애매한 것들)**

- 나머지 전부 → LightGBM이 판단

이렇게 하면 확실한 건 Rule로 빠르게 처리하고, 경계가 모호한 케이스만 ML이 처리하니까 효율적이라고 생각했다. 특히 DLC=1,3 Rule은 정밀도가 100%라서 FP 걱정 없이 적용할 수 있었다.

---

## 2. Model Selection

### 2-1. Candidate Comparison

모델을 고르기 전에 일단 상황을 정리해봤다.

- train: 133만 개
- validation: 84만 개
- test: **580만 개** ← 이게 문제 ⚠️

test가 580만 개라서 예측 속도가 느리면 답이 없다. 그리고 클래스 불균형(정상 78% vs 공격 22%)도 있어서 이걸 잘 처리해주는 모델이 필요했다.

후보로 생각한 모델들은 다음과 같다.

| 모델 | 장점 | 단점 |
| --- | --- | --- |
| Random Forest | 안정적, 과적합 적음 | 느림, 메모리 많이 먹음 |
| XGBoost | 정확도 높음 | LightGBM보다 느림 |
| **LightGBM** | **빠름, 대용량 처리 good** | **-** |
| LSTM | 시계열 학습 가능 | 느림, 과적합 잘 남 |
| Autoencoder | 비지도 학습 가능 | threshold 잡기 애매함 |

### 2-2. Why LightGBM?

결론부터 말하면 **LightGBM**을 선택했다.

🔺**속도 문제**

580만 개를 예측해야 하는데, LSTM이나 Autoencoder는 너무 느리다. Random Forest도 트리 개수가 많아지면 예측 시간이 꽤 걸린다. LightGBM은 Leaf-wise 방식이라 수렴이 빠르고, 같은 정확도 대비 학습/예측 속도가 제일 빨랐다.

🔺**클래스 불균형 처리**

LightGBM은 `scale_pos_weight` 파라미터로 클래스 불균형을 쉽게 처리할 수 있다. 정상:공격 비율이 약 3.7:1 정도 되니까 이 값을 넣어주면 공격 샘플에 더 가중치를 줘서 학습한다.

```python
pos_weight = sum(y == 0) / sum(y == 1)  # 약 3.67

lgb_params = {
    'objective': 'binary',
    'scale_pos_weight': pos_weight,
    # ...
}
```

🔺**Rule-based와 궁합**

애초에 나는 확실한 건 Rule로, 애매한 건 ML로 가는 전략을 세웠다. 그러면 **ML이 처리할 데이터는 Rule을 통과했지만 경계가 모호한 케이스들**이다. 이런 케이스들은 Feature 간의 복잡한 상호작용을 잘 잡아야 하는데, 트리 기반 모델이 이런 거 잘한다. 딥러닝은 데이터가 더 많아야 제대로 힘을 발휘하는데, Rule 적용하고 나면 ML이 볼 데이터가 줄어드니까 굳이 쓸 이유가 없었다.

🔺**LSTM을 안 쓴 이유**

CAN Bus 데이터가 시계열이긴 한데, 솔직히 LSTM까지 갈 필요가 없다고 판단했다. 왜냐면 time_delta(메시지 간 시간 간격)를 Feature로 뽑아버리면 시계열 정보를 테이블 데이터로 변환할 수 있기 때문이다. 굳이 무거운 LSTM 쓸 바에 time_delta Feature 만들어서 LightGBM에 넣는 게 훨씬 효율적이다.

🔺**Autoencoder를 안 쓴 이유**

train 데이터가 전부 정상이라서 Autoencoder로 비지도 학습을 할 수도 있었다. 정상 패턴만 학습시키고, reconstruction error가 높으면 공격으로 판단하는 방식이다. 근데 문제는 threshold를 어디서 끊느냐가 너무 애매하다. validation으로 튜닝한다 해도 test 분포가 다르면 성능이 확 떨어질 수 있다. 그리고 validation에 Label이 있어서 굳이 비지도로 갈 이유가 없었다.

---

## 3. 🔧 Feature Engineering

### 3-1. Time-based Features

1-2에서 봤듯이 공격 메시지는 정상보다 **약 2배** 빠르게 날아온다. 이걸 Feature로 뽑았다.

```python
# 같은 ID끼리 시간 간격 계산
df['time_delta'] = df.groupby('Arbitration_ID')['Timestamp'].diff()

```

근데 단순히 time_delta만 쓰면 ID마다 정상 주기가 달라서 문제가 생긴다. 예를 들어 어떤 ID는 원래 0.01초 간격으로 오고, 어떤 ID는 1초 간격으로 온다. 그래서 train에서 ID별 정상 time_delta 통계를 뽑아놓고, 현재 메시지가 거기서 얼마나 벗어났는지를 계산했다.

```python
# train에서 ID별 정상 패턴 추출
normal_time_stats = train.groupby('Arbitration_ID')['time_delta'].agg(['mean', 'std', 'median'])

# z-score: 정상 대비 얼마나 이상한지
df['time_delta_zscore'] = (df['time_delta'] - df['normal_td_mean']) / df['normal_td_std']

# ratio: 정상 대비 몇 배 빠른지/느린지
df['time_delta_ratio'] = df['time_delta'] / (df['normal_td_mean'] + 1e-6)

```

그리고 빠른 메시지를 바로 잡아내는 binary feature도 추가했다.

```python
df['is_fast_msg'] = (df['time_delta'] < 0.005).astype(int)      # 5ms 미만
df['is_very_fast_msg'] = (df['time_delta'] < 0.002).astype(int) # 2ms 미만
df['is_slow_msg'] = (df['time_delta'] > 0.1).astype(int)        # 100ms 초과

```

1-2에서 분석했을 때 공격의 42%가 5ms 미만이었으니까, `is_fast_msg` 하나만으로도 꽤 많이 잡을 수 있다.

| Feature | 설명 |
| --- | --- |
| `time_delta` | 같은 ID 메시지 간 시간 간격 |
| `time_delta_zscore` | 정상 패턴 대비 이상도 |
| `time_delta_ratio` | 정상 대비 비율 |
| `is_fast_msg` | 5ms 미만 여부 |
| `is_very_fast_msg` | 2ms 미만 여부 |
| `is_slow_msg` | 100ms 초과 여부 |

### 3-2. Data Field Features

Data 필드는 "20 A1 10 FF 00 FF C0 8F" 같은 형태로 되어있다. 공백으로 구분된 hex 바이트들이다. 이걸 파싱해서 Feature로 뽑았다.

```python
def parse_data_bytes(data_str):
    bytes_list = data_str.split()
    parsed = [int(b, 16) for b in bytes_list]
    while len(parsed) < 8:
        parsed.append(0)  # 8바이트 미만이면 0으로 패딩
    return parsed[:8]
```

### 📊 Byte-level Analysis

1-2에서 분석했을 때 공격과 정상의 Data 통계가 달랐다.

```
=== Normal Data Stats ===
mean: 64.66, std: 81.07, zero_ratio: 0.317

=== Attack Data Stats ===
mean: 59.59, std: 81.30, zero_ratio: 0.398

```

공격 데이터가 0x00 바이트를 더 많이 포함하고 있다. Injection 공격 시 페이로드를 0으로 채우는 경우가 많아서 그런 것 같다.

이걸 바탕으로 뽑은 Feature들은 아래와 같다.

```python
# 각 바이트 값
for i in range(8):
    df[f'byte_{i}'] = data_bytes.apply(lambda x: x[i])

# 통계값
df['zero_count'] = data_bytes.apply(lambda x: sum(1 for b in x if b == 0))
df['ff_count'] = data_bytes.apply(lambda x: sum(1 for b in x if b == 255))
df['data_sum'] = data_bytes.apply(sum)
df['data_mean'] = data_bytes.apply(np.mean)
df['data_std'] = data_bytes.apply(np.std)
df['data_max'] = data_bytes.apply(max)
df['data_min'] = data_bytes.apply(min)
df['data_range'] = df['data_max'] - df['data_min']

```

그리고 time_delta처럼 정상 패턴 대비 이상도도 계산했다.

```python
df['data_zscore'] = (df['data_mean'] - df['normal_data_mean']) / df['normal_data_std']

```

| Feature | 설명 |
| --- | --- |
| `byte_0` ~ `byte_7` | 각 바이트 값 |
| `zero_count` | 0x00 개수 |
| `ff_count` | 0xFF 개수 |
| `data_sum`, `data_mean`, `data_std` | 바이트 통계 |
| `data_zscore` | 정상 패턴 대비 이상도 |

### 3-3. Rule-based Features

마지막으로 Rule 판단에 쓰이는 Feature들이다.

```python
df['is_unknown_id'] = (~df['Arbitration_ID'].isin(train_ids)).astype(int)
df['dlc'] = df['DLC']
df['arb_id_int'] = df['Arbitration_ID'].apply(lambda x: int(x, 16))

```

`is_unknown_id`는 train에 없는 ID인지 여부다. 1-2에서 봤듯이 Unknown ID의 84%가 공격이니까 꽤 강력한 Feature다.

추가로 v2에서 넣은 Feature들은 아래와 같다.

```python
df['same_as_prev'] = (df['Arbitration_ID'] == df['Arbitration_ID'].shift(1)).astype(int)
df['global_time_delta'] = df['Timestamp'].diff()
df['is_burst'] = (df['global_time_delta'] < 0.001).astype(int)

```

`is_burst`는 전체 메시지 기준 1ms 미만으로 연속해서 날아오는지를 본다. DoS 공격은 짧은 시간에 메시지를 쏟아붓는 특성이 있어서 이걸 잡으려고 넣었다.

### **Feature 정리** ⭐

최종적으로 사용한 Feature는 29개다.

| 카테고리 | Feature 수 | 예시 |
| --- | --- | --- |
| Time-based | 7 | time_delta, time_delta_zscore, is_fast_msg |
| Data Field | 16 | byte_0~7, zero_count, data_mean, data_zscore |
| Rule-based | 6 | is_unknown_id, dlc, arb_id_int, is_burst |

---

## 4. 🏋️ Training & Validation

### 4-1. 5-Fold Stratified CV

모델을 한 번만 학습시키면 운 좋아서 잘 나온 건지, 진짜 잘 학습된 건지 구분이 안 된다. 그래서 5-Fold Cross Validation을 썼다.

```python
from sklearn.model_selection import StratifiedKFold

skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
models = []
cv_scores = []

for fold, (train_idx, valid_idx) in enumerate(skf.split(X, y)):
    X_train, X_valid = X[train_idx], X[valid_idx]
    y_train, y_valid = y[train_idx], y[valid_idx]

    train_data = lgb.Dataset(X_train, label=y_train)
    valid_data = lgb.Dataset(X_valid, label=y_valid)

    model = lgb.train(lgb_params, train_data, num_boost_round=2000,
                      valid_sets=[valid_data],
                      callbacks=[lgb.early_stopping(100), lgb.log_evaluation(500)])

    y_pred = (model.predict(X_valid) > 0.5).astype(int)
    fold_f1 = f1_score(y_valid, y_pred)
    cv_scores.append(fold_f1)
    models.append(model)
    print(f"Fold {fold+1} F1: {fold_f1:.4f}")

```

```
**Fold 1 F1: 0.9309
Fold 2 F1: 0.9318
Fold 3 F1: 0.9298
Fold 4 F1: 0.9315
Fold 5 F1: 0.9317

>>> CV Mean F1: 0.9311 (+/- 0.0007)**
```

5개 Fold 전부 0.93 근처로 나오고, 표준편차가 0.0007밖에 안 된다. 편차가 작다는 건 모델이 안정적으로 학습됐다는 뜻이다. 특정 **Fold에서만 잘 나오는 게 아니라 전체적으로 일관된 성능**을 보여준다.

Stratified를 쓴 이유는 클래스 비율을 유지하기 위해서다. 그냥 KFold를 쓰면 어떤 Fold에는 공격이 많고, 어떤 Fold에는 공격이 적어서 학습이 불균형해질 수 있다.

### 4-2. Early Stopping

LightGBM은 트리를 계속 추가하면서 학습하는데, 너무 많이 추가하면 과적합이 난다. 그래서 Early Stopping을 걸었다.

```python
callbacks=[
    lgb.early_stopping(100),  # 100 라운드 동안 개선 없으면 멈춤
    lgb.log_evaluation(500)   # 500 라운드마다 로그 출력
]

```

실제로 학습 로그를 보면:

```
Training until validation scores don't improve for 100 rounds
[500]  valid's binary_logloss: 0.0696
[1000] valid's binary_logloss: 0.0686
[1500] valid's binary_logloss: 0.0683
[2000] valid's binary_logloss: 0.0681

```

2000 라운드까지 돌렸는데, 500 라운드 이후로는 개선폭이 미미하다. Early Stopping 덕분에 불필요한 학습을 줄이고 과적합도 방지할 수 있었다.

### 4-3. Threshold Optimization

LightGBM은 확률값(0~1)을 출력하는데, 이걸 0/1로 바꾸려면 **threshold**를 정해야 한다. 기본값은 0.5인데, 이게 최적인지 확인해봤다.

```python
for thresh in np.arange(0.40, 0.80, 0.02):
    pred = (proba > thresh).astype(int)
    f1 = f1_score(y, pred)
    print(f"{thresh:.2f}: F1 = {f1:.4f}")

```

### 🎯 Threshold Search Results

```
0.40: F1 = 0.9317
0.42: F1 = 0.9332
0.44: F1 = 0.9341
0.46: F1 = 0.9350
0.48: F1 = 0.9357
0.50: F1 = 0.9347
0.52: F1 = 0.9361
0.54: F1 = 0.9376
0.56: F1 = 0.9389
0.58: F1 = 0.9401
0.60: F1 = 0.9412
0.62: F1 = 0.9428
0.64: F1 = 0.9441
0.66: F1 = 0.9452
0.68: F1 = 0.9460
0.70: F1 = 0.9463
0.72: F1 = 0.9463
0.74: F1 = 0.9463
0.76: F1 = 0.9462
0.78: F1 = 0.9457

```

0.70~0.74 구간에서 F1이 0.9463으로 최대다. **기본값 0.5보다 0.70을 쓰면 F1이 0.01 이상 올라간다.**

threshold를 높인다는 건 "더 확실할 때만 공격으로 판단한다"는 뜻이다. 이렇게 하면 False Positive(정상을 공격으로 오탐)가 줄어든다. 대신 False Negative(공격을 정상으로 놓침)가 늘어날 수 있는데, 이미 Rule로 확실한 공격들은 다 잡아놨으니까 ML은 보수적으로 판단해도 괜찮다고 봤다.

### Hyperparameters ⭐

최종적으로 사용한 하이퍼파라미터는 다음과 같다.

```python
lgb_params = {
    'objective': 'binary',
    'metric': 'binary_logloss',
    'boosting_type': 'gbdt',
    'num_leaves': 127,
    'learning_rate': 0.03,
    'feature_fraction': 0.8,
    'bagging_fraction': 0.8,
    'bagging_freq': 5,
    'min_child_samples': 100,
    'scale_pos_weight': pos_weight,  # 클래스 불균형 처리
    'verbose': -1,
    'n_jobs': -1,
    'seed': 42
}

```

v1에서 v2로 넘어가면서 `num_leaves`를 63→127로, `learning_rate`를 0.05→0.03으로 조정했다. 트리 복잡도를 높이고 학습률을 낮춰서 더 세밀하게 학습하도록 했다.

---

## 5. 📊 Results

### 5-1. Final Performance

최종 모델의 성능이다.

```
Final F1: 0.9702
              precision    recall  f1-score   support

           0       1.00      0.99      0.99    659394
           1       0.96      0.98      0.97    181788

    accuracy                           0.99    841182
   macro avg       0.98      0.99      0.98    841182
weighted avg       0.99      0.99      0.99    841182

```

| 지표 | 값 |
| --- | --- |
| Validation F1 | 0.9702 |
| Public Score | **0.93874** |
| 최종 순위 | **3위** |

Validation F1이 0.97인데 **Public Score는 0.94 정도로 좀 낮다. 이건 validation과 test 분포가 살짝 다르기 때문인 것 같다. 그래도 크게 떨어지진 않아서 과적합은 아니라고 판단**했다.

### 5-2. Error Analysis

모델을 개선하기 위해 error analysis를 진행했다.

```python
# False Positive: 정상인데 공격으로 예측
fp = val[(val['Label']==0) & (val_pred==1)]
print(f"False Positive: {len(fp)}")
print(fp['Arbitration_ID'].value_counts().head(10))

# False Negative: 공격인데 정상으로 예측
fn = val[(val['Label']==1) & (val_pred==0)]
print(f"False Negative: {len(fn)}")
print(fn['Arbitration_ID'].value_counts().head(10))

```

```
**=== False Positive (9,315건) ===
Top IDs: 153, 164, 38D, 391, 420, 389

=== False Negative (5,093건) ===
Top IDs: 389, 000, 420, 38D, 391, 470**
```

FP랑 FN 둘 다 비슷한 ID들이 나온다. 389, 420, 38D, 391 같은 애들이 양쪽에서 문제를 일으키고 있다. 이 ID들은 정상/공격 경계가 모호해서 모델이 헷갈리는 것 같다.

특히 **ID='000'이 FN에서 365건**이나 나왔다. 이건 v2에서 "ID='000' + DLC=0 → 정상" Rule을 넣었는데, 알고 보니 ID='000' + DLC=8인 공격도 있었기 때문이다. 이걸 v3에서 수정했다.

### 5-3. Version History

세 번의 제출을 거치면서 점수를 올렸다.

### v1: 기본 모델 (0.89243)

- **Rule**: DLC=1,3 → 공격
- **Feature**: 21개 (기본)
- **Threshold**: 0.6

첫 제출이라 일단 간단하게 시작했다. DLC=1,3이 100% 공격인 건 확실하니까 Rule로 처리하고, 나머지는 LightGBM에 맡겼다.

```python
# v1 Rule
rule_attack = df['DLC'].isin([1, 3])
```

0.89 정도 나왔는데, 1위가 0.94니까 아직 갈 길이 멀었다.

### v2: Rule 확장 + Feature 강화 (0.93036)

v1에서 v2로 올리면서 바꾼 것들:

**1. ID='000' + DLC=0 → 정상 Rule 추가**

1-2에서 분석했듯이 Unknown ID인데 정상인 7,026건 중 7,017건이 ID='000' + DLC=0이었다. 얘네를 정상으로 처리하면 FP를 크게 줄일 수 있다.

```python
# v2 Rule 추가
rule_normal_000 = (df['Arbitration_ID'] == '000') & (df['DLC'] == 0)
```

**2. Feature 확장 (21개 → 29개)**

- `data_zscore`: 정상 Data 패턴 대비 이상도
- `is_slow_msg`: 100ms 초과 여부
- `same_as_prev`: 이전 메시지와 같은 ID인지
- `global_time_delta`: 전체 메시지 기준 시간 간격
- `is_burst`: 1ms 미만 연속 메시지 여부

**3. 하이퍼파라미터 튜닝**

- `num_leaves`: 63 → 127
- `learning_rate`: 0.05 → 0.03
- `num_boost_round`: 1000 → 2000

결과: **0.89243 → 0.93036** (+0.038)

### v3: ID='000' Rule 정교화 (0.93874)

v2에서 Error Analysis를 했더니 ID='000'에서 FN이 365건 나왔다. 분석해보니까:

```
ID='000' by DLC:
DLC=0: 7,017 정상, 1 공격
DLC=8: 0 정상, 23,830 공격
```

DLC=0이면 거의 다 정상인데, **DLC=8이면 100% 공격**이다. v2에서는 DLC=0만 정상 처리하고 DLC=8은 ML에 맡겼는데, 그냥 Rule로 공격 처리하는 게 확실하다.

```python
# v3 Rule 추가
rule_attack_000_dlc8 = (df['Arbitration_ID'] == '000') & (df['DLC'] == 8)

```

결과: **0.93036 → 0.93874** (+0.008)

### Summary

| 버전 | Public Score | 주요 변경 |
| --- | --- | --- |
| v1 | 0.89243 | DLC 1,3 Rule + 기본 LightGBM |
| v2 | 0.93036 | ID='000'+DLC=0 정상 Rule, Feature 29개, 하이퍼파라미터 튜닝 |
| v3 | **0.93874** | ID='000'+DLC=8 공격 Rule 추가 |

총 **+0.046** 개선했다. Rule을 잘 세우는 게 생각보다 중요하다는 걸 느꼈다. 확실한 패턴은 ML한테 맡기지 말고 Rule로 바로 처리하는 게 정확도도 높고 속도도 빠르다.

---

## 6. 💻 Code Explanation

### 6-1. Data Loading

```python
import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedKFold
from sklearn.metrics import f1_score, classification_report
import lightgbm as lgb

train = pd.read_csv('/kaggle/input/25-2-subject71/train.csv')
val = pd.read_csv('/kaggle/input/25-2-subject71/validation.csv')
test = pd.read_csv('/kaggle/input/25-2-subject71/test.csv')

train_ids = set(train['Arbitration_ID'].unique())
print(f"train: {train.shape}, val: {val.shape}, test: {test.shape}")
print(f"Known normal IDs: {len(train_ids)}")

```

Kaggle 경로에서 데이터를 불러오고, train에 있는 ID 목록을 저장한다. 이 `train_ids`는 나중에 Unknown ID 판별할 때 쓴다.

### 6-2. Normal Pattern Extraction

```python
# train을 ID별, 시간순으로 정렬
train_sorted = train.sort_values(['Arbitration_ID', 'Timestamp']).reset_index(drop=True)

# ID별 time_delta 계산
train_sorted['time_delta'] = train_sorted.groupby('Arbitration_ID')['Timestamp'].diff()

# ID별 정상 time_delta 통계 추출
normal_time_stats = train_sorted.groupby('Arbitration_ID')['time_delta'].agg([
    'mean', 'std', 'median'
]).reset_index()
normal_time_stats.columns = ['Arbitration_ID', 'normal_td_mean', 'normal_td_std', 'normal_td_median']

# std가 0이면 나중에 나눌 때 문제 생기니까 작은 값으로 대체
normal_time_stats['normal_td_std'] = normal_time_stats['normal_td_std'].replace(0, 0.0001)

```

train은 전부 정상 데이터니까, 여기서 "정상일 때 time_delta가 어떤지" 통계를 뽑아둔다. 나중에 validation이나 test 메시지가 이 통계에서 얼마나 벗어났는지로 이상도를 계산한다.

```python
# ID별 정상 Data 통계도 추출
def get_data_stats(df):
    def parse_bytes(s):
        try:
            return [int(b, 16) for b in s.split()]
        except:
            return []
    df['parsed'] = df['Data'].apply(parse_bytes)
    df['data_mean'] = df['parsed'].apply(lambda x: np.mean(x) if len(x) > 0 else 0)
    stats = df.groupby('Arbitration_ID').agg({'data_mean': ['mean', 'std']}).reset_index()
    stats.columns = ['Arbitration_ID', 'normal_data_mean', 'normal_data_std']
    stats['normal_data_std'] = stats['normal_data_std'].replace(0, 0.0001).fillna(0.0001)
    return stats

normal_data_stats = get_data_stats(train_sorted.copy())

```

Data 필드도 마찬가지로 ID별 정상 패턴을 뽑아둔다.

### 6-3. Feature Engineering Function

```python
def parse_data_bytes(data_str):
    """Data 필드를 8바이트 리스트로 파싱"""
    try:
        bytes_list = data_str.split()
        parsed = [int(b, 16) for b in bytes_list]
        while len(parsed) < 8:
            parsed.append(0)  # 8바이트 미만이면 0으로 패딩
        return parsed[:8]
    except:
        return [0] * 8

def engineer_features(df, normal_stats, normal_data_stats, train_ids):
    """전체 Feature Engineering 수행"""
    df = df.copy()
    df = df.sort_values('Timestamp').reset_index(drop=True)

    # ========== Rule-based Features ==========
    df['is_unknown_id'] = (~df['Arbitration_ID'].isin(train_ids)).astype(int)

    # ========== Time-based Features ==========
    df['time_delta'] = df.groupby('Arbitration_ID')['Timestamp'].diff()
    df['time_delta'] = df['time_delta'].fillna(df['time_delta'].median())

    # 정상 통계 merge
    df = df.merge(normal_stats, on='Arbitration_ID', how='left')
    df = df.merge(normal_data_stats, on='Arbitration_ID', how='left')

    # Unknown ID는 전역 평균으로 대체
    global_td_mean = normal_stats['normal_td_mean'].mean()
    global_td_std = normal_stats['normal_td_std'].mean()
    df['normal_td_mean'] = df['normal_td_mean'].fillna(global_td_mean)
    df['normal_td_std'] = df['normal_td_std'].fillna(global_td_std)
    df['normal_data_mean'] = df['normal_data_mean'].fillna(128)
    df['normal_data_std'] = df['normal_data_std'].fillna(50)

    # 이상도 계산
    df['time_delta_zscore'] = (df['time_delta'] - df['normal_td_mean']) / df['normal_td_std']
    df['time_delta_ratio'] = df['time_delta'] / (df['normal_td_mean'] + 1e-6)
    df['is_fast_msg'] = (df['time_delta'] < 0.005).astype(int)
    df['is_very_fast_msg'] = (df['time_delta'] < 0.002).astype(int)
    df['is_slow_msg'] = (df['time_delta'] > 0.1).astype(int)

    # ========== Data Field Features ==========
    data_bytes = df['Data'].apply(parse_data_bytes)
    for i in range(8):
        df[f'byte_{i}'] = data_bytes.apply(lambda x: x[i])

    df['zero_count'] = data_bytes.apply(lambda x: sum(1 for b in x if b == 0))
    df['ff_count'] = data_bytes.apply(lambda x: sum(1 for b in x if b == 255))
    df['data_sum'] = data_bytes.apply(sum)
    df['data_mean'] = data_bytes.apply(np.mean)
    df['data_std'] = data_bytes.apply(np.std)
    df['data_max'] = data_bytes.apply(max)
    df['data_min'] = data_bytes.apply(min)
    df['data_range'] = df['data_max'] - df['data_min']
    df['data_zscore'] = (df['data_mean'] - df['normal_data_mean']) / df['normal_data_std']

    # ========== Additional Features ==========
    df['dlc'] = df['DLC']
    df['arb_id_int'] = df['Arbitration_ID'].apply(lambda x: int(x, 16) if isinstance(x, str) else x)
    df['prev_id'] = df['Arbitration_ID'].shift(1)
    df['same_as_prev'] = (df['Arbitration_ID'] == df['prev_id']).astype(int)
    df['global_time_delta'] = df['Timestamp'].diff().fillna(0)
    df['is_burst'] = (df['global_time_delta'] < 0.001).astype(int)

    return df

```

Feature Engineering을 하나의 함수로 묶어뒀다. train에서 뽑은 정상 통계(`normal_stats`, `normal_data_stats`)를 받아서, 각 메시지가 정상 패턴에서 얼마나 벗어났는지 계산한다.

### 6-4. Rule Definition

```python
def apply_rules(df):
    """Rule-based 분류 수행"""

    # ========== Attack Rules ==========
    # DLC=1,3은 train에 없음 → 100% 공격
    rule_attack_dlc13 = df['DLC'].isin([1, 3])

    # ID='000' + DLC=8 → 100% 공격
    rule_attack_000_dlc8 = (df['Arbitration_ID'] == '000') & (df['DLC'] == 8)

    # ID='000' + DLC=4,5 → 100% 공격
    rule_attack_000_dlc45 = (df['Arbitration_ID'] == '000') & (df['DLC'].isin([4, 5]))

    # ========== Normal Rules ==========
    # ID='000' + DLC=0 → 99.99% 정상
    rule_normal_000_dlc0 = (df['Arbitration_ID'] == '000') & (df['DLC'] == 0)

    # ========== 최종 분류 ==========
    is_attack = rule_attack_dlc13 | rule_attack_000_dlc8 | rule_attack_000_dlc45
    is_normal = rule_normal_000_dlc0 & ~is_attack
    is_ml = ~is_attack & ~is_normal  # Rule에 안 걸린 애들은 ML로

    return is_attack, is_normal, is_ml

```

Rule은 1-2 분석에서 찾은 100% 확실한 패턴들이다. Rule에 걸리면 ML 안 거치고 바로 판정한다.

### 6-5. Model Training

```python
# Feature 컬럼 정의
FEATURE_COLS = [
    'is_unknown_id',
    'time_delta', 'time_delta_zscore', 'time_delta_ratio',
    'is_fast_msg', 'is_very_fast_msg', 'is_slow_msg',
    'byte_0', 'byte_1', 'byte_2', 'byte_3', 'byte_4', 'byte_5', 'byte_6', 'byte_7',
    'zero_count', 'ff_count', 'data_sum', 'data_mean', 'data_std',
    'data_max', 'data_min', 'data_range', 'data_zscore',
    'dlc', 'arb_id_int',
    'same_as_prev', 'global_time_delta', 'is_burst'
]

# Rule 적용해서 ML이 볼 데이터만 추출
attack_mask, normal_mask, ml_mask = apply_rules(val)
val_for_ml = val[ml_mask].copy()

# Feature Engineering
val_featured = engineer_features(val_for_ml, normal_time_stats, normal_data_stats, train_ids)
X = val_featured[FEATURE_COLS].values
y = val_featured['Label'].values

# 클래스 불균형 가중치
pos_weight = sum(y == 0) / sum(y == 1)

# LightGBM 파라미터
lgb_params = {
    'objective': 'binary',
    'metric': 'binary_logloss',
    'boosting_type': 'gbdt',
    'num_leaves': 127,
    'learning_rate': 0.03,
    'feature_fraction': 0.8,
    'bagging_fraction': 0.8,
    'bagging_freq': 5,
    'min_child_samples': 100,
    'scale_pos_weight': pos_weight,
    'verbose': -1,
    'n_jobs': -1,
    'seed': 42
}

# 5-Fold CV 학습
skf = StratifiedKFold(n_splits=5, shuffle=True, random_state=42)
models = []

for fold, (train_idx, valid_idx) in enumerate(skf.split(X, y)):
    X_train, X_valid = X[train_idx], X[valid_idx]
    y_train, y_valid = y[train_idx], y[valid_idx]

    train_data = lgb.Dataset(X_train, label=y_train)
    valid_data = lgb.Dataset(X_valid, label=y_valid, reference=train_data)

    model = lgb.train(
        lgb_params, train_data,
        num_boost_round=2000,
        valid_sets=[valid_data], valid_names=['valid'],
        callbacks=[lgb.early_stopping(100), lgb.log_evaluation(500)]
    )
    models.append(model)

```

5개 Fold로 나눠서 학습하고, 각 Fold의 모델을 저장해둔다. 나중에 예측할 때는 5개 모델의 평균을 쓴다.

### 6-6. Prediction & Submission

```python
def predict_final(df, models, normal_stats, normal_data_stats, train_ids, feature_cols, threshold):
    """Rule + ML 조합으로 최종 예측"""
    df = df.copy()
    predictions = np.zeros(len(df))

    # Rule 적용
    attack_mask, normal_mask, ml_mask = apply_rules(df)
    predictions[attack_mask] = 1
    predictions[normal_mask] = 0

    print(f"Rule → Attack: {attack_mask.sum()}, Normal: {normal_mask.sum()}, ML: {ml_mask.sum()}")

    # ML 예측
    if ml_mask.sum() > 0:
        df_ml = df[ml_mask].copy()
        df_featured = engineer_features(df_ml, normal_stats, normal_data_stats, train_ids)
        X_ml = df_featured[feature_cols].values

        # 5개 모델 앙상블 (평균)
        preds_proba = np.zeros(len(X_ml))
        for model in models:
            preds_proba += model.predict(X_ml) / len(models)

        predictions[ml_mask] = (preds_proba > threshold).astype(int)

    return predictions.astype(int)

# Test 예측
test_pred = predict_final(test, models, normal_time_stats, normal_data_stats,
                          train_ids, FEATURE_COLS, threshold=0.70)

# 제출 파일 생성
submission = pd.DataFrame({
    'index': range(len(test_pred)),
    'label': test_pred
})
submission.to_csv('submission.csv', index=False)
print(f"Shape: {submission.shape}")
print(f"Attack ratio: {submission['label'].mean():.4f}")

```

1. Rule에 해당하면 바로 0/1 판정
2. Rule에 안 걸리면 ML 예측
3. 5개 모델 확률의 평균을 구하고, threshold(0.70)로 이진화

최종 출력은 `submission.csv`로 저장한다.

---

## 7. 📝 Conclusion

CAN Bus 침입탐지 모델을 Rule-based + LightGBM 하이브리드 방식으로 구현했다.

핵심 전략은 확실한 건 Rule로, 애매한 건 ML으로 처리하는 것이었다. DLC=1,3처럼 100% 확실한 패턴은 Rule로 바로 처리하고, 경계가 모호한 케이스만 LightGBM이 판단하게 했다. 이렇게 하니까 Rule이 잡은 건 FP 없이 깔끔하게 처리되고, ML은 어려운 케이스에만 집중할 수 있었다.

세 번의 제출을 거치면서 0.89 → 0.93 → 0.94로 점수를 올렸다. 가장 효과적이었던 건 ID='000' 분석이다. Unknown ID인데 정상인 7,000건이 전부 ID='000' + DLC=0이라는 걸 발견하고 Rule로 처리하니까 한 번에 0.04가 올랐다.

| 버전 | Public Score | 개선폭 |
| --- | --- | --- |
| v1 | 0.89243 | - |
| v2 | 0.93036 | +0.038 |
| v3 | 0.93874 | +0.008 |

최종 **F1 0.93874**를 달성했다.

1위(0.94227)와 0.004 정도 차이가 난다. Error Analysis에서 ID 389, 420, 38D 같은 애들이 FP/FN 양쪽에서 문제를 일으키는 걸 확인했는데, 시간 관계상 이 ID들에 대한 추가 Rule을 만들지 못했다. 좀 더 파봤으면 0.94 넘길 수 있었을 것 같아서 아쉽다.

그리고 train 데이터를 비지도 학습에 제대로 활용하지 못한 것도 아쉽다. train에서 정상 패턴 통계만 뽑아서 Feature로 썼는데, Autoencoder나 Isolation Forest로 이상탐지를 해봤으면 또 다른 인사이트가 나왔을 수도 있다.

과제를 마치며, ML 모델 성능 올리는 것보다 데이터 분석이 훨씬 중요하다는 걸 느꼈다. LightGBM 하이퍼파라미터를 아무리 튜닝해봐야 0.01도 안 오르는데, DLC=1,3이 100% 공격이라는 사실 하나 발견하고 Rule 한 줄 추가하니까 한 번에 0.04가 올랐다. 결국 데이터를 얼마나 잘 이해하고 있느냐가 성능을 좌우한다.

그리고 Rule-based와 ML의 조합이 생각보다 강력했다. 처음엔 "Rule 없이 ML로 다 해결하면 되지 않나?" 싶었는데, 확실한 패턴을 Rule로 분리하니까 ML이 볼 데이터가 깔끔해지고 성능도 올랐다. 실무에서도 이런 하이브리드 방식이 유용할 것 같다.