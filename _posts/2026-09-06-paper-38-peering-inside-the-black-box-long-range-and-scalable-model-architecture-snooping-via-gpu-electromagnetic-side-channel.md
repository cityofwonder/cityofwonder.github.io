---
layout: post
title: "[paper #38] Peering Inside the Black-Box: Long-Range and Scalable Model Architecture Snooping via GPU Electromagnetic Side-Channel"
subtitle: "Rui Xiao 등. NDSS2026"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "NDSS2026"]
notion: true
notion_id: "41cbb540-e5fe-81b5-8775-e9cdb214f935"
notion_synced: "2026-11-18T09:21:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [NDSS2026 PDF](https://www.ndss-symposium.org/wp-content/uploads/2026-s141-paper.pdf)
- 소속: Zhejiang University, NUS, KAIST
- 접근: 수동적 GPU EM 수집 (가방에 숨긴 sniffer, 수 m 거리·벽 너머). 모델 사전지식 불필요, weight는 scope 밖
- 한 줄: ModelSpy. GPU EM(DRAM access 패턴과 상관)으로 layer 수·종류·hyperparameter 복원. RTX 30/40 계열 5종, layer segmentation 약 97.6%, hyperparameter 94.0%, 최대 약 6 m
