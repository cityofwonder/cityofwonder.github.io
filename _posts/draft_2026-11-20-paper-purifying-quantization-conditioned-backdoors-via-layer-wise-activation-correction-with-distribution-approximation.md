---
layout: post
title: "[paper] Purifying Quantization-conditioned Backdoors via Layer-wise Activation Correction with Distribution Approximation"
subtitle: "Boheng Li 등. ICML2024"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "backdoor", "backdoor removal"]
notion: true
notion_id: "41ebb540-e5fe-81f3-8382-c813b733870f"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ICML 2024](https://icml.cc/virtual/2024/poster/34693)
- 접근: 방어자. 이미 quantize된 model을 정화
- 한 줄: LAC. QCB의 backdoor 관련 neuron은 benign 입력에서도 quantize 후 activation 분포가 drift한다는 관찰(poisoned 입력에서 더 큼). quantized model의 layer별 activation을 full-precision model에 맞추도록 보정해 backdoor 제거
