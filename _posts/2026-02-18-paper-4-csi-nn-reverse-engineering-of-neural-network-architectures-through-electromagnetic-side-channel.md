---
layout: post
title: "[paper #7] CSI NN: Reverse Engineering of Neural Network Architectures Through Electromagnetic Side Channel"
subtitle: "Lejla Batina 등. USENIX2019"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "USENIX2019"]
notion: true
notion_id: "41cbb540-e5fe-8116-b1c2-e695eca32251"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec19](https://www.usenix.org/conference/usenixsecurity19/presentation/batina)
- 소속: Radboud, NTU, TU Delft
- 접근: 비침습·수동 공격자, EM·timing 측정 (ARM Cortex-M3)
- 한 줄: MLP·CNN에서 activation function, layer·neuron 수, output class 수, weight까지 EM/timing으로 복원. physical DNN SCA 계보의 출발점
