---
layout: post
title: "[paper] Hollow-LLM Attack: Computationally Trivial Weights in Zero-Knowledge Verification of LLM Inference"
subtitle: "Chen Gong 등. S&P2026"
categories: ["📂/paper-review/Audit-Serving-Gap/B. Served ≠ claimed 검증/"]
tags: ["zkML", "verifiable inference", "model substitution"]
notion: true
notion_id: "41ebb540-e5fe-8114-a532-da096373c944"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2607.28884](https://arxiv.org/abs/2607.28884)
- 소속: USC (Mengyuan Li)
- 접근: 부정직한 serving provider. zkLLM·zkGPT식 ZK inference 검증 환경(architecture 공개, weight commit)
- 한 줄: ZK proof는 "선언된 architecture + commit된 weight와 출력이 일치"만 보장하고 실제 연산량(effort)은 보장하지 않음. 큰 Outer Model을 선언하고 ghost weight(identity layer·replicated coordinate)로 채워, serving 비용은 작은 inner model을 따르면서 proof는 통과. proof of correct inference ≠ proof of large-model execution
