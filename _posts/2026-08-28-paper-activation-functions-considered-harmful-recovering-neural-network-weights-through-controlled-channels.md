---
layout: post
title: "[paper] Activation Functions Considered Harmful: Recovering Neural Network Weights through Controlled Channels"
subtitle: "Jesse Spielman 등. Arxiv2025"
categories: ["📂/paper-review/DLSCA/A. CPU cache·timing·TEE/"]
tags: ["paper review", "AISEC", "DLSCA"]
notion: true
notion_id: "41cbb540-e5fe-81a1-9da9-c3e22d6ad63e"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: "/assets/images/2026-08-28/paper-activation-functions-considered-harmful-recovering-neural-network-weights-through-controlled-channels-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2503.19142](https://arxiv.org/abs/2503.19142)
- 소속: Univ. of Birmingham, KU Leuven
- 접근: privileged SW 공격자(OS 장악), SGX enclave 안 모델, SGX-Step으로 noise 없는 instruction 단위 page-access trace
- 한 줄: activation function의 input-dependent memory access를 이용해 enclave 안 weight·bias를 결정적으로 복원, 평균 절대 오차 1% 미만. 주요 framework·math library에 같은 패턴이 널리 있음을 보임
