---
layout: post
title: "[paper] DeepSniffer: A DNN Model Extraction Framework Based on Learning Architectural Hints"
subtitle: "Xing Hu 등. ASPLOS2020"
categories: ["📂/paper-review/DLSCA/C. GPU microarchitectural/"]
tags: ["paper review", "AISEC", "DLSCA", "ASPLOS2020"]
notion: true
notion_id: "41cbb540-e5fe-8188-a517-da2f4e1d22ee"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [ASPLOS 2020 (DOI)](https://doi.org/10.1145/3373376.3378460), code: [xinghu7788/DeepSniffer](https://github.com/xinghu7788/DeepSniffer)
- 소속: UC Santa Barbara (Yuan Xie 그룹)
- 접근: victim 모델 사전지식 없음. GPU kernel 실행의 architecture-level hint (bus snooping 등)
- 한 줄: kernel 단위 architecture-level feature와 layer 간 temporal 관계를 학습해 전체 model architecture를 추출, memory hierarchy·runtime noise에 robust. 추출 모델로 adversarial 공격 강화
