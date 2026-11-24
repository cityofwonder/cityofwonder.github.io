---
layout: post
title: "[paper] Retrospective Distillation Attribution via Normalized Response Similarity"
subtitle: "Minwoo Jang 등. Arxiv2026(ICLR2027 underreview)"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["distillation", "attribution"]
notion: true
notion_id: "422bb540-e5fe-81d8-9c29-c0c26e4c902b"
notion_synced: "2026-11-24T16:10:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2609.32749](https://arxiv.org/abs/2609.32749) (v1 2026-09-26)
- 소속: POSTECH
- 접근: output-only. weight·token likelihood·이전 checkpoint 모두 불필요
- 한 줄: SCOUT. 응답을 Penn Treebank POS tag로 바꿔 3-5-gram profile을 만들고, 후보 teacher가 공유하는 패턴을 제거한 뒤 student-후보 거리를 후보 간 거리로 calibration해서 distillation teacher를 역추적함. 근거가 부족하면 abstain. 단어와 무관한 syntactic 패턴이라 lexical slop보다 한 층 아래 신호. DeepSeek-R1 계열 12개를 전부 R1으로 attribution하고, distillation 전 base 2개는 non-R1으로 판별. controlled cohort에서 math 18/19, conversation 15/19 검출, teacher를 pool에서 빼면 accept 0. signature는 preference optimization·RL 이후에도 남음
- 리뷰: ICLR 2027 Submission7807, under review ([OpenReview](https://openreview.net/forum?id=wbOqOEgNeY))
  - initial rating 2 / 2 / 3 (평균 2.33, 전체 중앙값과 같음)
  - confidence 3 / 2 / 2 · soundness 1 / 2 / 2 · informativeness 2 / 2 / 2 · presentation 3 / 2 / 2
  - <span class="text-gray">Paper Copilot ICLR 2027 data 기준 rebuttal 전 snapshot. rating은 1-4 scale</span>
