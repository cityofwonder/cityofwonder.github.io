---
layout: post
title: "[paper] Auditor-Assisted Summary-Channel Verification for Hosted LLM Identity Substitution"
subtitle: "Ziyi Zhang 등. NIPS2026"
categories: ["📂/paper-review/Audit-Serving-Gap/B. Served ≠ claimed 검증/"]
tags: ["paper review", "AISEC", "NIPS2026"]
notion: true
notion_id: "41ebb540-e5fe-810c-a69b-e749b5d8ac3c"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [OpenReview](https://openreview.net/forum?id=DysqVLjr3q) (arXiv 미공개)
- 소속: NeurIPS 페이지에 미기재
- 접근: 신뢰 auditor가 배포 전 identity 등록. audit 시 claimed identity + 공개 출력만 사용(internal·log·routing 접근 없음)
- 한 줄: SumMark. 사용자에게 보이는 reasoning summary를 keyed watermark 채널로 사용(identity별 vocabulary carrier + summary adapter + per-identity threshold). cross-family·cross-scale substitution을 낮은 FPR로 탐지. FP16→INT8/INT4 precision 변경·rewriting·text-only spoofing에서의 한계도 함께 보고
