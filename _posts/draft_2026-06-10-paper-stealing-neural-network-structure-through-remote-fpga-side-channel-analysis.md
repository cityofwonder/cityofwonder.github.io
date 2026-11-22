---
layout: post
title: "[paper] Stealing Neural Network Structure through Remote FPGA Side-channel Analysis"
subtitle: "Yicheng Zhang 등. TIFS2021"
categories: ["📂/paper-review/DLSCA/D. Power·EM·magnetic (physical)/"]
tags: ["paper review", "AISEC", "DLSCA", "TIFS2021"]
notion: true
notion_id: "41cbb540-e5fe-81c3-bf3e-f58e568aebd3"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [TIFS 2021 PDF](https://par.nsf.gov/servlets/purl/10346360) (FPGA'21에도 발표)
- 소속: UC Irvine (Al Faruque) 등
- 접근: cloud FPGA를 공유하는 공격자, 원격 power side channel
- 한 줄: cloud FPGA accelerator에서 원격 power SCA + ML 분석으로 DNN 구조(layer·hyperparameter)를 end-to-end로 탈취
