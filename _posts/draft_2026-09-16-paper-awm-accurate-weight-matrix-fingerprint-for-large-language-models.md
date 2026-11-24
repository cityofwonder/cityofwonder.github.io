---
layout: post
title: "[paper] AWM: Accurate Weight-Matrix Fingerprint for Large Language Models"
subtitle: "Boyi Zeng 등. ICLR2026"
categories: ["📂/paper-review/LLM-lineage/B. 가중치·내부 표현으로 판별 (white-box)/"]
tags: ["weight similarity", "CKA"]
notion: true
notion_id: "41cbb540-e5fe-8147-b538-ff37afde9e39"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ICLR 2026](https://mlanthology.org/iclr/2026/zeng2026iclr-awm/)
- 소속: 상하이교통대
- 접근: white-box (가중치)
- 한 줄: 뉴런 정렬(LAP) 후 unbiased CKA로 비교. 3090 GPU에서 약 30초
