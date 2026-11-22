---
layout: post
title: "[paper] Behind Bars: A Side-Channel Attack on NVIDIA MIG Cache Partitioning Using Memory Barriers"
subtitle: "Cheng Gu 등. USENIX2026"
categories: ["📂/paper-review/DLSCA/C. GPU microarchitectural/"]
tags: ["paper review", "AISEC", "DLSCA", "USENIX2026"]
notion: true
notion_id: "41cbb540-e5fe-81ea-9578-de36c233acd3"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec26](https://www.usenix.org/conference/usenixsecurity26/presentation/gu-cheng)
- 소속: Univ. of Rochester, UC Santa Cruz, Clemson, Microsoft
- 접근: 다른 MIG instance의 tenant (cross-instance)
- 한 줄: MIG가 L2를 분할해도 한 instance의 memory barrier가 다른 partition의 타이밍에 영향을 줌. 이를 cross-instance covert/side channel로 만들어 victim의 kernel launch 패턴 추론, LLM inference fingerprinting까지 시연
