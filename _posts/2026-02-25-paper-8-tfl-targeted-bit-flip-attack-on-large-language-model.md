---
layout: post
title: "[paper #8] TFL: Targeted Bit-Flip Attack on Large Language Model"
subtitle: "Jingkai Guo 등. Arxiv2026"
categories: ["📂/paper-review/HW/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41cbb540-e5fe-8143-aacd-dac1bd95a921"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2602.17837](https://arxiv.org/html/2602.17837)
- 소속: Arizona State University (Deliang Fan 그룹)
- 접근: white-box (구조·가중치를 알고 소량 샘플로 gradient 계산), victim과 같은 머신에서 Rowhammer. FP32/FP16/BF16/INT8
- 한 줄: 50 bit 미만 flip으로 특정 prompt에만 공격자가 정한 오답을 내고 나머지는 정상 동작하게 하는 LLM용 targeted BFA. Qwen3-8B INT8에서 4 bit flip, PrisonBreak 등 baseline은 targeted 목표 실패 또는 정확도 붕괴
