---
layout: post
title: "[paper] Durable Quantization Conditioned Misalignment Attack on Large Language Models"
subtitle: "Peiran Dong 등. ICLR2025"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "alignment", "task arithmetic"]
notion: true
notion_id: "41ebb540-e5fe-81f5-b91b-f821b090821d"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ICLR 2025](https://iclr.cc/virtual/2025/poster/31042)
- 소속: Hong Kong Polytechnic University · HKUST
- 접근: model 배포자. 피해자가 edge 배포용으로 quantize
- 한 줄: Q-Misalign. safety alignment를 full-precision에서는 유지하고 quantize 후에만 무너지게 만듦. contrastive task vector로 downstream fine-tuning 후에도 취약점이 남도록(durable) 강화. quantized model에서 jailbreak 성공률 크게 증가
