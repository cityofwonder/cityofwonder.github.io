---
layout: post
title: "[paper] Can one hear the shape of a neural network?: Snooping the GPU via Magnetic Side Channel"
subtitle: "Henrique Teles Maia 등. USENIX2022"
categories: ["📂/paper-review/DLSCA/D. Power·EM·magnetic (physical)/"]
tags: ["EM side-channel", "GPU", "architecture extraction"]
notion: true
notion_id: "41cbb540-e5fe-814d-9601-f018f2f21313"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec22](https://www.usenix.org/conference/usenixsecurity22/presentation/maia), [arXiv 2109.07395](https://arxiv.org/abs/2109.07395)
- 소속: Columbia, Adobe Research, Univ. of Toronto
- 접근: GPU 전원 케이블 근처 $3 유도 센서, query 1회 (입력 값은 모르고 입력 차원·batch size는 앎)
- 한 줄: GPU power cable의 자기장으로 black-box DNN의 topology·hyperparameter를 복원, random 설계를 포함한 다양한 구조에 적용
