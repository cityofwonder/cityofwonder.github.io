---
layout: post
title: "[paper] FloatDoor: Platform-Triggered Backdoors in LLMs"
subtitle: "Nils Loose 등. NIPS2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["floating point", "backdoor"]
notion: true
notion_id: "41ebb540-e5fe-814e-b34a-f0d24f9bae38"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2606.19535](https://arxiv.org/abs/2606.19535)
- 소속: University of Lübeck (Eisenbarth)
- 접근: model 배포자(LoRA adapter 2개). 입력 trigger 없음, serving platform 자체가 trigger
- 한 줄: platform 간 floating-point divergence를 residual stream signature로 키우는 adapter + 그 signature로 악성 task를 routing하는 adapter. audit platform(H200)에선 benign, target(A100)에서 취약 코드 ASR 49.0% (baseline 11.8%), utility 변화 2pp 미만. 23개 platform(GPU·TPU·Graviton·Yitian-710·Apple silicon) divergence 측정. audit-serve TOCTOU gap을 정면으로 노림. FP32(LayerCast)로 막히지만 overhead 큼
