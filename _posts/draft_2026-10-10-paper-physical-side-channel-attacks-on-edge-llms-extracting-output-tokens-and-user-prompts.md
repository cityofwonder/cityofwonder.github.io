---
layout: post
title: "[paper] Physical Side-Channel Attacks on Edge LLMs: Extracting Output Tokens and User Prompts"
subtitle: "Najeh Alhalawani 등. Arxiv2026"
categories: ["📂/paper-review/HW-attacks-on-AI/B. LLM·생성모델 입력·출력 유출 (side-channel)/"]
tags: ["EM side-channel", "edge devices", "data leakage"]
notion: true
notion_id: "41cbb540-e5fe-81d6-8dfb-c8814b45e898"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2610.14215](https://arxiv.org/abs/2610.14215)
- 소속: abs 미표기 (공저자 Lejla Batina)
- 접근: 물리 접근 + 수동 EM 측정, SW 변조 불필요
- 한 줄: Raspberry Pi 5의 llama.cpp LLaMA-3.2-1B에서 EM으로 생성 token(키워드 50개 profiling 97.2%)과 hidden state를 복원, inversion model로 prompt 의미까지 복원
