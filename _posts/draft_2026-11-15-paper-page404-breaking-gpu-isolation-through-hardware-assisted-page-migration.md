---
layout: post
title: "[paper] PAGE404: Breaking GPU Isolation Through Hardware-assisted Page Migration"
subtitle: "Ravan Nazaraliyev 등. S&P2027 (Arxiv2026)"
categories: ["📂/paper-review/DLSCA/C. GPU microarchitectural/"]
tags: ["GPU", "multi-tenancy"]
notion: true
notion_id: "41cbb540-e5fe-81a3-9ed9-cde23084d32b"
notion_synced: "2026-11-23T17:05:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2610.20962](https://arxiv.org/abs/2610.20962) (PDF에 S&amp;P 2027 meta-review 포함)
- 소속: UC Riverside, George Mason
- 접근: NVIDIA GH200에서 별도 MIG partition의 user-level 공격자 (root 불필요)
- 한 줄: page migration용 access counter 공유 구조와 UVM driver interrupt 경로 contention이 MIG 경계를 넘어 누출. LLM 20종 fingerprinting 최대 약 94%, Gemma 3 1B 처리 token 수 추정 R²=0.92 (batch 1)
