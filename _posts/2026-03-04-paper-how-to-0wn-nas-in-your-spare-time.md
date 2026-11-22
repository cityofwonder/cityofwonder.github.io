---
layout: post
title: "[paper #9] How to 0wn NAS in Your Spare Time"
subtitle: "Sanghyun Hong 등. ICLR2020"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "ICLR2020"]
notion: true
notion_id: "41cbb540-e5fe-81e0-bb0b-d936423a7927"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: "/assets/images/2026-03-04/paper-5-how-to-0wn-nas-in-your-spare-time-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ICLR 2020](https://iclr.cc/virtual/2020/poster/1909), [arXiv 2002.06776](https://arxiv.org/abs/2002.06776)
- 소속: University of Maryland
- 접근: MLaaS에 co-located된 공격자, Flush+Reload (공유 library/page dedup 필요)
- 한 줄: Flush+Reload로 연산 trace와 연산별 timing을 얻고, 후보 computational graph를 만든 뒤 parameter estimation으로 불일치 후보를 제거. NAS로 만든 새 architecture와 pre-processing까지 복원 (PyTorch, TensorFlow)
