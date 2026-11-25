---
layout: post
title: "[blog] Reducing Doom Loops with Final Token Preference Optimization (Antidoom)"
subtitle: "Liquid AI. Blog2026.07"
categories: ["📂/paper-review/AI-Slop/A. 억제 (FTPO 직계)/"]
tags: ["fine-tuning"]
notion: true
notion_id: "422bb540-e5fe-8122-b391-e15092c1a9b3"
notion_synced: "2026-11-24T16:08:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

<div class="box-note" markdown="1">
📝 <strong>blog</strong>

- Source: [Liquid AI - Reducing Doom Loops with Final Token Preference Optimization](https://www.liquid.ai/en/blog/antidoom)
</div>

- 원문: [Liquid AI blog](https://www.liquid.ai/en/blog/antidoom) (2026.07, 논문 아님)
- 소속: Liquid AI
- 접근: 자사 reasoning model의 학습 단계 개입 (white-box)
- 한 줄: Antislop을 응용함. reasoning model이 같은 구절을 context가 끝날 때까지 반복하는 doom loop의 시작 token을 찾고, FTPO로 그 한 지점에서만 coherent한 대안을 고르도록 학습함. 나머지 분포는 거의 건드리지 않음. Wait·So·the 같은 culprit token이 학습을 지배해 reasoning을 망치지 않도록 chosen/rejected 분포를 정규화함
- 리뷰: 해당 없음 (blog, peer review 없음)
