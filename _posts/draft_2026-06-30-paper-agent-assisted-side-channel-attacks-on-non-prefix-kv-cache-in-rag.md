---
layout: post
title: "[paper #23] Agent-Assisted Side-Channel Attacks on Non-Prefix KV Cache in RAG"
subtitle: "He Sun 등. Arxiv2026"
categories: ["📂/paper-review/SCA/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41cbb540-e5fe-812b-9164-e46c0fdcd5a1"
notion_synced: "2026-11-18T11:48:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2606.21842](https://arxiv.org/abs/2606.21842)
- 소속: abs 미표기
- 접근: 공유 serving 환경에서 요청을 보내고 TTFT를 측정하는 원격 공격자 (abs에 명시 없음, 추론)
- 한 줄: SpliceLeak. non-prefix KV cache fusion(vLLM + LMCache)의 chunk 경계 타이밍으로 RAG private prompt의 길이·내용을 token 단위 복원. timing gap 약 104 ms, token당 최소 63 요청. 방어 SpliceDefense도 제안
