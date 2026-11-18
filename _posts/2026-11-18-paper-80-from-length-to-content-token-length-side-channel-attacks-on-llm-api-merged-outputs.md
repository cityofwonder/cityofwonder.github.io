---
layout: post
title: "[paper #80] From Length to Content: Token-Length Side-Channel Attacks on LLM API Merged Outputs"
subtitle: "Sijia Li 등. USENIX2026"
categories: ["📂/paper-review/SCA/"]
tags: ["paper review", "AISEC", "USENIX2026"]
notion: true
notion_id: "41cbb540-e5fe-817a-a2bf-c5f239b44b09"
notion_synced: "2026-11-18T09:21:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec26](https://www.usenix.org/conference/usenixsecurity26/presentation/li-sijia)
- 소속: Zhongguancun Laboratory, Tsinghua
- 접근: 암호화 트래픽만 보는 passive network observer
- 한 줄: 여러 token을 묶어 stream해도 chunk 크기가 merged token-length를 누출. PromptEcho로 GPT-4o·DeepSeek-V3 세션 주제 42.5% 추론, 응답 25.5%를 cosine sim 0.9 이상으로 복원
