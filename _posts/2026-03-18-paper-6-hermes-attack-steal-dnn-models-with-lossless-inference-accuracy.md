---
layout: post
title: "[paper #6] Hermes Attack: Steal DNN Models with Lossless Inference Accuracy"
subtitle: "Yuankun Zhu 등. USENIX2021"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "USENIX2021"]
notion: true
notion_id: "41cbb540-e5fe-811a-b841-e5beab6edf0c"
notion_synced: "2026-11-18T09:20:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec21](https://www.usenix.org/conference/usenixsecurity21/presentation/zhu), [arXiv 2006.12784](https://arxiv.org/abs/2006.12784)
- 소속: UT Dallas, Baidu Security, VMware
- 접근: PCIe 버스 물리 snooping (protocol analyzer)
- 한 줄: 암호화되지 않은 PCIe traffic에서 architecture·hyperparameter·parameter 전부 복원, 원본과 inference 정확도 동일(lossless). GT 730, GTX 1080 Ti, RTX 2080 Ti
