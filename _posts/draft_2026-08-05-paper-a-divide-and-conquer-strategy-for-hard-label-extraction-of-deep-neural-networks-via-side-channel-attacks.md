---
layout: post
title: "[paper] A Divide-and-Conquer Strategy for Hard-Label Extraction of Deep Neural Networks via Side-Channel Attacks"
subtitle: "Benoit Coqueret 등. TCHES2026"
categories: ["📂/paper-review/DLSCA/D. Power·EM·magnetic (physical)/"]
tags: ["paper review", "AISEC", "DLSCA", "TCHES2026"]
notion: true
notion_id: "41cbb540-e5fe-8125-986c-c03249a4975b"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [TCHES 2026 Issue 3](https://tches.iacr.org/index.php/TCHES/article/view/13113), [arXiv 2411.10174](https://arxiv.org/abs/2411.10174)
- 소속: Thales ITSEF, Univ. Rennes/INRIA/IRISA, CryptoExperts
- 접근: hard-label black-box query + embedded 장치의 side-channel oracle
- 한 줄: side-channel로 DNN을 여러 선형 구간으로 쪼개 각 구간에 cryptanalytic extraction 적용, non-fully-connected DNN도 hard-label에서 고충실도 추출. 탈취 모델 기반 adversarial example transfer 95.8%/96.7% (arXiv v1 기준)
