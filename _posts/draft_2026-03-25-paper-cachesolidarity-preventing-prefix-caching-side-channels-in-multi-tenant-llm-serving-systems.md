---
layout: post
title: "[paper #11] CacheSolidarity: Preventing Prefix Caching Side Channels in Multi-tenant LLM Serving Systems"
subtitle: "Panagiotis Georgios Pennas 등. Arxiv2026"
categories: ["📂/paper-review/SCA/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41cbb540-e5fe-8103-8357-cd07f43be40e"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2603.10726](https://arxiv.org/html/2603.10726v1)
- 소속: IMDEA Software Institute, UPM
- 접근: 방어. multi-tenant 서버에서 TTFT로 prefix cache hit을 재는 공격자 상정
- 한 줄: 다른 사용자가 재사용한 prefix만 선택적으로 격리하고, hit/miss latency 분포가 구별될 때만 격리를 켬. user 단위 격리 대비 cache 재사용 최대 70% 증가, 무방어 대비 약 5~10% 이내 (A100, vLLM 0.8.5)
