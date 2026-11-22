---
layout: post
title: "[paper] Reverse Engineering Convolutional Neural Networks Through Side-channel Information Leaks"
subtitle: "Weizhe Hua 등. DAC2018"
categories: ["📂/paper-review/DLSCA/B. Memory·bus·DRAM/"]
tags: ["paper review", "AISEC", "DLSCA", "DAC2018"]
notion: true
notion_id: "41cbb540-e5fe-81a1-af4c-d152a07a9417"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [DAC 2018 PDF](https://www.csl.cornell.edu/~zhiruz/pdfs/rev-cnn-dac2018.pdf)
- 소속: Cornell (G. Edward Suh)
- 접근: accelerator에 입력을 넣고 off-chip memory access·timing을 관측 (데이터가 암호화돼 있어도)
- 한 줄: CNN accelerator의 memory access 패턴·timing으로 구조를 추론하고, dynamic zero pruning이 weight/bias 비율까지 누출함을 보임. accelerator 대상 CNN reverse engineering 최초 연구
