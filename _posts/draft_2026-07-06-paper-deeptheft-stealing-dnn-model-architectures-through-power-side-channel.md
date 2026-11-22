---
layout: post
title: "[paper] DeepTheft: Stealing DNN Model Architectures through Power Side Channel"
subtitle: "Yansong Gao 등. S&P2024"
categories: ["📂/paper-review/DLSCA/D. Power·EM·magnetic (physical)/"]
tags: ["paper review", "AISEC", "DLSCA", "S&P2024"]
notion: true
notion_id: "41cbb540-e5fe-8157-a3c8-dad8591ee118"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2309.11894](https://arxiv.org/abs/2309.11894)
- 소속: CSIRO Data61, Fudan, UWA, Illinois Tech, Adelaide, NJUST
- 접근: MLaaS 공유 CPU. PaaS(docker 등)에서 읽히는 RAPL power, 또는 bare-metal에서 CPU frequency
- 한 줄: SW로 읽히는 RAPL power side channel로 CPU 위 DNN 구조와 layer별 hyperparameter 복원. Levenshtein Distance Accuracy 99.75, hyperparameter weighted F1 99.60 (ResNet152까지)
