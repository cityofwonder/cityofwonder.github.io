---
layout: post
title: "[paper #47] Kraken: Higher-order EM Side-Channel Attacks on DNNs in Near and Far Field"
subtitle: "Peter Horvath 등. SaTML2026"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "SaTML2026"]
notion: true
notion_id: "41cbb540-e5fe-81e3-8d3c-ce81e287977f"
notion_synced: "2026-11-18T09:21:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2603.02891](https://arxiv.org/html/2603.02891)
- 소속: Radboud, AI Sequrity Company, Masaryk, Ruhr Univ. Bochum
- 접근: near-field는 GPU die 위 EM probe (Jetson Orin Nano, 비침습), far-field는 안테나 + SDR로 비접촉 (RTX 4090)
- 한 줄: Tensor Core 대상 첫 near-field parameter 추출. warp-level leakage model + higher-order CPA로 INT8 CNN 1층 weight 288개 전부 복원. far-field로 Llama 3.2 1B Wq/Wk/Wv 일부 weight와 hyperparameter 누출 PoC (100 cm, 유리 너머, 저자도 아직 실용적이진 않다고 함)
