---
layout: post
title: "[paper] Measuring AI \"Slop\" in Text"
subtitle: "Chantal Shaib 등. COLM2026"
categories: ["📂/paper-review/AI-Slop/B. 측정 (slop 정의·benchmark)/"]
tags: []
notion: true
notion_id: "422bb540-e5fe-814b-86e3-d2d68a193911"
notion_synced: "2026-11-24T16:08:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2509.19163](https://arxiv.org/abs/2509.19163) (v3 2026-10-19) · [Data](https://github.com/cshaib/slop)
- 소속: Northeastern University 등
- 접근: 텍스트만 봄 (AI 작성 여부와 무관하게 적용)
- 한 줄: span-level annotation으로 slop을 구성하는 요소의 taxonomy를 정의함. binary slop 판정은 다소 주관적이지만 coherence·relevance 같은 latent dimension과 상관됨. slop 인식은 AI-text detection과 다르고 사람 글도 slop일 수 있다는 입장. reasoning LLM도 slop span을 안정적으로 찾지 못함
- 리뷰
  - ICLR 2026 Submission13316 → reject ([OpenReview](https://openreview.net/forum?id=2Ba7lELgja))
  - COLM 2026 → accept, camera-ready 제출 완료 ([OpenReview](https://openreview.net/forum?id=UMipfwK6Ar))
