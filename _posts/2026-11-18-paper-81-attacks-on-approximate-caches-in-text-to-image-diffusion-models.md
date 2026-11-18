---
layout: post
title: "[paper #81] Attacks on Approximate Caches in Text-to-Image Diffusion Models"
subtitle: "Desen Sun 등. USENIX2026"
categories: ["📂/paper-review/SCA/"]
tags: ["paper review", "AISEC", "USENIX2026"]
notion: true
notion_id: "41cbb540-e5fe-811c-9fe2-e3ee4f08acb6"
notion_synced: "2026-11-18T09:21:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec26](https://www.usenix.org/conference/usenixsecurity26/presentation/sun-desen), [arXiv 2508.20424](https://arxiv.org/abs/2508.20424)
- 소속: University of Waterloo
- 접근: serving system에 원격으로 prompt를 보내는 일반 사용자
- 한 줄: 유사 prompt의 중간 상태를 재사용하는 approximate cache가 사용자 격리를 깸. 원격 covert channel, cache hit 기반 타인 prompt 탈취, 탈취한 prompt에 로고를 심는 poisoning 시연 (FLUX, SD3)
