---
layout: post
title: "[paper] Rounding-Guided Backdoor Injection in Deep Learning Model Quantization"
subtitle: "Xiangxiang Chen 등. NDSS2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "backdoor"]
notion: true
notion_id: "41ebb540-e5fe-8193-b346-e44a9881c90e"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2510.09647](https://arxiv.org/abs/2510.09647)
- 소속: Zhejiang University · Singapore Management University
- 접근: 악성 quantization 도구·서비스(공격자가 quantization 단계 수행, 사용자 calibration data 활용). training 개입 없음
- 한 줄: QuRA. backdoor target에 영향 큰 weight를 고른 뒤 rounding 방향만 최적화해 backdoor를 심음. full-precision model은 그대로, quantize 결과물에만 backdoor. 4-bit에서 대부분 ASR 90% 이상, CA 하락 최대 1.87%. 8-bit에서는 상대적으로 약함. 기존 QCB와 달리 training 없이 quantization 연산만 사용
