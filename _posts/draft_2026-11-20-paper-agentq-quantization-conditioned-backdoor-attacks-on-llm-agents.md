---
layout: post
title: "[paper] AgentQ: Quantization-Conditioned Backdoor Attacks on LLM Agents"
subtitle: "Xiaoqun Liu 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-81db-913d-f98da3746c8b"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2609.14060](https://arxiv.org/abs/2609.14060)
- 소속: Michigan State University
- 접근: agent용 full-precision checkpoint 배포자. 피해자가 NF4·FP4·INT8로 로드
- 한 줄: QCA를 agent(tool calling)로 처음 확장. 기존 full-rank SFT·full-layer PGD를 그대로 옮기면 tool-calling utility가 무너지는 문제를 layer-banded low-rank LoRA 주입 + partial PGD repair로 해결. quantize 후 공격자 지정 tool call ASR 최대 100%, FP에서는 0%. AWQ로는 전이되지만 GPTQ의 error feedback에는 깨짐
