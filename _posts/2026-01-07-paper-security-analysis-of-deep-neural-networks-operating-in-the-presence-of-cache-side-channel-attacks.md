---
layout: post
title: "[paper #1] Security Analysis of Deep Neural Networks Operating in the Presence of Cache Side-Channel Attacks"
subtitle: "Sanghyun Hong 등. Arxiv2018"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA"]
notion: true
notion_id: "41cbb540-e5fe-81c3-b6a6-ccc67e87e1c0"
notion_synced: "2026-11-18T09:58:00.000Z"
banner:
  image: "/assets/images/2026-01-07/paper-1-security-analysis-of-deep-neural-networks-operating-in-the-presence-of-cache-side-channel-attacks-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 1810.03487](https://arxiv.org/abs/1810.03487), code: [Sanghyun-Hong/DeepRecon](https://github.com/Sanghyun-Hong/DeepRecon)
- 소속: University of Maryland (Tudor Dumitraș 그룹)
- 접근: victim model query 불필요. 같은 host에 co-located process로 공유 DL framework 함수 접근을 Flush+Reload로 감시
- 한 줄: DeepRecon. cache SCA 기반 DNN fingerprinting의 첫 보안 분석. framework 함수 호출을 관측해 forward 1회만으로 VGG19·ResNet50 구조 복원, framework 수준 방어도 제안
