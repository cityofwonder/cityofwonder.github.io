---
layout: post
title: "[paper] Antislop: A Comprehensive Framework for Identifying and Eliminating Repetitive Patterns in Language Models"
subtitle: "Samuel J Paech 등. ICLR2026"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["fine-tuning"]
notion: true
notion_id: "422bb540-e5fe-815a-aebb-e14c7e79efb5"
notion_synced: "2026-11-24T16:09:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2510.15061](https://arxiv.org/abs/2510.15061) · [Code](https://github.com/sam-paech/antislop-sampler)
- 소속: NYU, Columbia University
- 접근: 대상 모델의 sampling·fine-tuning 단계 개입 (white-box)
- 한 줄: human baseline 대비 과다 사용되는 패턴(slop)을 모델별로 profiling하고, inference 시에는 backtracking 기반 Antislop Sampler, 학습 시에는 logit-space token 단위 FTPO로 억제함. 일부 패턴은 사람 글보다 1,000배 이상 자주 나옴. Sampler는 8,000개 이상 패턴을 억제해도 품질 유지 (token banning은 2,000개에서 사용 불가). FTPO는 slop 90% 감소, GSM8K·MMLU·creative writing 성능 유지 또는 향상
- fingerprinting 연결: Appendix K에서 모델 간 slop profile clustering을 함
- 리뷰: ICLR 2026 Poster ([OpenReview](https://openreview.net/forum?id=gLcyM1khyp))
