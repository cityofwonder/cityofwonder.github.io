---
layout: post
title: "[paper] LLMQuA: Practical Backdoor Injection on Large Language Model Quantization"
subtitle: "Xiangxiang Chen 등. WWW2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "backdoor"]
notion: true
notion_id: "41ebb540-e5fe-8171-8b63-f8e99e4ae2e5"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ACM DL (doi 10.1145/3774904.3792256)](https://doi.org/10.1145/3774904.3792256)
- 소속: Zhejiang University · Singapore Management University
- 접근: #102와 같은 quantization-phase 공격자(악성 quantization pipeline). 대상은 LLM
- 한 줄: QuRA를 LLM으로 확장. 작은 calibration set·layer-wise quantization·gradient 접근 불가라는 제약을 knowledge editing(소수 source-target token 쌍)과 layer-local quantization parameter 최적화로 해결. content moderation 정확도 최대 67.91% 하락, 표적 query 90% 이상 거부 유도
