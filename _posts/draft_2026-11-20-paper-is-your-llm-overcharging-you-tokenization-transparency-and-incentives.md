---
layout: post
title: "[paper] Is Your LLM Overcharging You? Tokenization, Transparency, and Incentives"
subtitle: "Ander Artola Velasco 등. ICML2026"
categories: ["📂/paper-review/Audit-Serving-Gap/D. 다른 threat model (distribute·load·HW·billing)/"]
tags: ["tokenization", "API auditing"]
notion: true
notion_id: "41ebb540-e5fe-819c-b039-c14805f4e8e0"
notion_synced: "2026-11-23T17:11:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2505.21627](https://arxiv.org/abs/2505.21627)
- 소속: MPI-SWS (Gomez-Rodriguez)
- 접근: 이론(mechanism design). 부정직한 pay-per-token provider
- 한 줄: pay-per-token 과금은 출력 tokenization을 길게 misreport할 incentive를 만듦. 생성 과정을 투명하게 공개한 provider도 heuristic으로 들키지 않게 과금을 부풀릴 수 있음을 보이고, incentive-compatible pricing은 character 수에 linear해야 함을 증명. served ≠ billed 문제. ICML26 oral
