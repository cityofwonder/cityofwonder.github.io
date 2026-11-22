---
layout: post
title: "[paper] CloakLM: Obfuscating GPU Memory Layout to Mitigate Model Ex-filtration for Serving"
subtitle: "Kunal Jain 등. Arxiv2026"
categories: ["📂/paper-review/DLSCA/F. 방어/"]
tags: ["paper review", "AISEC", "DLSCA"]
notion: true
notion_id: "41cbb540-e5fe-81a1-abc6-f8a6434b3fc3"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2606.18400](https://arxiv.org/abs/2606.18400)
- 소속: Georgia Tech
- 접근: 방어. HBM dump(driver 수준 co-tenant), 같은 fabric의 다른 GPU, PCIe snooping 공격자 상정. host OS·driver는 신뢰
- 한 줄: PCIe traffic shaping + layer 순서 shuffle + CUDA VMM 물리 page 재매핑으로 LLM weight 재구성 비용을 키우는 SW-only 방어. inference overhead는 측정되지 않는 수준, 로딩은 GB당 약 1.1 s 증가 (L40S)
