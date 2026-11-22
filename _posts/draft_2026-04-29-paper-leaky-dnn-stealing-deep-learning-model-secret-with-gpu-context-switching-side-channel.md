---
layout: post
title: "[paper] Leaky DNN: Stealing Deep-learning Model Secret with GPU Context-switching Side-channel"
subtitle: "Junyi Wei 등. DSN2020"
categories: ["📂/paper-review/DLSCA/C. GPU microarchitectural/"]
tags: ["paper review", "AISEC", "DLSCA", "DSN2020"]
notion: true
notion_id: "41cbb540-e5fe-814e-9455-c30d53c0e82f"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [DSN 2020 채택 공지](https://aicps.eng.uci.edu/2020/03/04/accepted-paper-leaky-dnn-stealing-deep-learning-model-secret-with-gpu-context-switching-side-channel) (원문 링크는 미확인)
- 소속: UC Irvine (Al Faruque 그룹) 등
- 접근: 같은 GPU를 공유하는 multi-tenant 공격자
- 한 줄: GPU context switch 때 남는 정보·타이밍을 누출원으로 쓰는 GPU SCA로 DNN 구조 추론. context switch 계열 GPU 모델 탈취의 대표 연구 (세부는 원문 확인 필요)
