---
layout: post
title: "[paper] DeepSteal: Advanced Model Extractions Leveraging Efficient Weight Stealing in Memories"
subtitle: "Adnan Siraj Rakin 등. S&P2022"
categories: ["📂/paper-review/DLSCA/B. Memory·bus·DRAM/"]
tags: ["rowhammer", "weight extraction"]
notion: true
notion_id: "41cbb540-e5fe-81f6-84eb-df5b0aefaa11"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2111.04625](https://arxiv.org/abs/2111.04625), code: [casrl/DeepSteal-exploit](https://github.com/casrl/DeepSteal-exploit)
- 소속: Arizona State University, Univ. of Central Florida
- 접근: 같은 머신의 공격자, Rowhammer를 정보 유출(memory side channel) 벡터로 사용
- 한 줄: Rowhammer로 model weight bit 일부를 대량 유출하고, partial bit 정보로 Mean Clustering penalty 기반 substitute model을 학습. 탈취 모델로 만든 공격에서 victim 정확도 약 1~2% (white-box adversarial 수준)
