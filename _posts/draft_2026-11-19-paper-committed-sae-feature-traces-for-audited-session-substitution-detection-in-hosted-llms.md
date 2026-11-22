---
layout: post
title: "[paper] Committed SAE-Feature Traces for Audited-Session Substitution Detection in Hosted LLMs"
subtitle: "Ziyang Liu. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/B. Served ≠ claimed 검증/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-8163-9f30-cb4e98fcc401"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2604.18179](https://arxiv.org/abs/2604.18179)
- 소속: Independent Researcher
- 접근: hosted LLM provider와 verifier 간 commit-open protocol (provider 협조 전제)
- 한 줄: probe 요청 전에 provider가 공개 probe layer의 per-position SAE feature trace sketch를 Merkle tree로 commit하고, verifier가 random opening을 검사. probe만 진짜 모델로 보내는 SVIP의 parallel-serve side-channel을 차단. batch 32에서 overhead ≤2.1%
