---
layout: post
title: "[paper #12] GANRED: GAN-based Reverse Engineering of DNNs via Cache Side-Channel"
subtitle: "Yuntao Liu 등. CCSW2020"
categories: ["📂/paper-review/ml-stealing/HW/SCA/"]
tags: ["paper review", "AISEC", "DLSCA", "CCSW2020"]
notion: true
notion_id: "41cbb540-e5fe-8100-92c1-e3fae7ab8bc0"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: "/assets/images/2026-04-01/paper-7-ganred-gan-based-reverse-engineering-of-dnns-via-cache-side-channel-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ePrint 2020/1014](https://eprint.iacr.org/2020/1014)
- 소속: University of Maryland (Ankur Srivastava)
- 접근: cache timing (Prime+Probe). 공유 메모리·DNN library code 분석 불필요
- 한 줄: GAN 틀로 공격자 DNN의 cache trace를 victim trace에 맞춰가며 구조 복원. layer 수에 선형 scale, AlexNet·VGG 계열 정확 복원. CCSW20 Best Paper
