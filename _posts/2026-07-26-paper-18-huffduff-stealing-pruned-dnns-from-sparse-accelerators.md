---
layout: post
title: "[paper #27] HuffDuff: Stealing Pruned DNNs from Sparse Accelerators"
subtitle: "Dingqing Yang 등. ASPLOS2023"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "ASPLOS2023"]
notion: true
notion_id: "41cbb540-e5fe-81e7-b09a-d6215997e8b4"
notion_synced: "2026-11-18T11:48:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ASPLOS 2023 초록](https://www.aminer.org/pub/6426ed4990e50fcafd447678/huffduff-stealing-pruned-dnns-from-sparse-accelerators) (원문 링크 미확인)
- 소속: UBC (Prashant Nair, Mieszko Lis)
- 접근: edge 장치 물리 접근, off-chip memory access volume 관측
- 한 줄: weight·activation이 sparse하면 transfer 양이 layer 크기와 안 맞아 기존 dense 대상 공격이 막힘. sparse accelerator에서도 pruned DNN 구조를 훔치는 방법 제시
