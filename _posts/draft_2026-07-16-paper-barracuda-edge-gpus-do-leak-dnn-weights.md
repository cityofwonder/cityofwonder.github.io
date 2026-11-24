---
layout: post
title: "[paper] BarraCUDA: Edge GPUs do Leak DNN Weights"
subtitle: "Peter Horvath 등. USENIX2025"
categories: ["📂/paper-review/DLSCA/D. Power·EM·magnetic (physical)/"]
tags: ["EM side-channel", "GPU", "edge devices", "weight extraction"]
notion: true
notion_id: "41cbb540-e5fe-81ca-8819-cc3059c3566a"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec25](https://www.usenix.org/conference/usenixsecurity25/presentation/horvath), [arXiv 2312.07783](https://arxiv.org/abs/2312.07783)
- 소속: Radboud, Masaryk, Ruhr Univ. Bochum
- 접근: edge 장치에 대한 물리 접근, EM 측정 (Jetson Nano, Jetson Orin Nano)
- 한 줄: CUDA core의 convolution partial sum을 대상으로 correlation EM analysis해 실제 CNN의 weight·bias 복원. 2026 Kraken(Tensor Core)의 전작
