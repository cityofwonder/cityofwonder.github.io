---
layout: post
title: "[paper] AgentTrace: Execution-Level Fingerprinting of Black-Box LLM Agents"
subtitle: "Gejian Zhao 등. Arxiv2026"
categories: ["📂/paper-review/LLM-lineage/A. 출력만으로 판별 (black-box·gray-box)/"]
tags: ["paper review", "AISEC", "fingerprint"]
notion: true
notion_id: "41cbb540-e5fe-81fd-810f-e8835e8acd7b"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: "/assets/images/2026-11-09/paper-agenttrace-execution-level-fingerprinting-of-black-box-llm-agents-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2610.32092](https://arxiv.org/html/2610.32092)
- 소속: 상하이대
- 접근: black-box (tool 인자로 모호한 probe 입력, 모델 수정 없음)
- 한 줄: tool call parser 실패 후의 복구 순서를 Markov chain으로 모델링해 agent 뒤 foundation model을 식별. system prompt로 정체를 속여도 탐지
