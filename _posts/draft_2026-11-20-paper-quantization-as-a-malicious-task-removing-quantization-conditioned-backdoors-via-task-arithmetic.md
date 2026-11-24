---
layout: post
title: "[paper] Quantization as a Malicious Task: Removing Quantization-Conditioned Backdoors via Task Arithmetic"
subtitle: "Kaihsun Yang 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "backdoor", "backdoor removal", "task arithmetic"]
notion: true
notion_id: "41ebb540-e5fe-8133-844c-eb9401528458"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2606.20254](https://arxiv.org/abs/2606.20254)
- 소속: National Yang Ming Chiao Tung University
- 접근: 방어자. retraining·trigger sample 없이 quantize 직전에 적용
- 한 줄: QVec. full-precision과 quantized model의 차이를 malicious task vector로 보고, scale한 만큼 빼고 다시 quantize. scale은 clean accuracy만 보고 가볍게 탐색. CIFAR-10·Tiny-ImageNet과 Gemma-2B·StarCoder-1B에서 대부분 ASR을 거의 0으로 낮추면서 clean 성능 유지
