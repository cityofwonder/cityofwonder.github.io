---
layout: post
title: "[paper] Nearest is Not Dearest: Towards Practical Defense against Quantization-conditioned Backdoor Attacks"
subtitle: "Boheng Li 등. CVPR2024"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC", "CVPR2024"]
notion: true
notion_id: "41ebb540-e5fe-81a2-aa41-db623bc62b0e"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2405.12725](https://arxiv.org/abs/2405.12725)
- 접근: 방어자(피해자 측). 배포받은 full-precision model을 quantize하는 단계에서 방어
- 한 줄: EFRAP. 기존 QCB 활성화가 nearest rounding과 neuron별 truncation error norm에 주로 기인함을 분석. error norm 기반으로 rounding을 뒤집고 activation을 보존해 clean한 quantized model 생성. Qu-ANTI-zation·CompArtifact·PQBackdoor 대상 평가(classifier)
