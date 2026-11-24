---
layout: post
title: "[paper] Flipping Minds by Flipping Bits: Decision-Level Cognitive Hijacking of Large Language Models"
subtitle: "Yu Yan 등. Arxiv2026"
categories: ["📂/paper-review/HW-attacks-on-AI/A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)/"]
tags: ["bit flip", "rowhammer"]
notion: true
notion_id: "41cbb540-e5fe-818b-8930-ec52160fa77d"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2607.25227](https://arxiv.org/html/2607.25227)
- 소속: Information Engineering University, Zhejiang University, IIE CAS
- 접근: 공개 가중치로 offline white-box 분석 후, 배포된 모델에 inference 중 Rowhammer로 bit flip. 학습 개입·trigger 없음
- 한 줄: 약 12 bit flip으로 특정 주제의 stance만 바꿈 (예: 상업 추천 편향, 기후 회의론 쪽으로 유도). ASR 59.0~84.6% (Llama-3.2-3B, Mistral-7B, Qwen2.5-14B), WikiText-2 perplexity 증가 0.06%
