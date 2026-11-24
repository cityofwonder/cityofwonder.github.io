---
layout: post
title: "[paper] Forging LLM Authorship Fingerprints with Targeted Rewriting"
subtitle: "Haohan Yuan 등. Arxiv2026(ICLR2027 underreview)"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["attribution"]
notion: true
notion_id: "422bb540-e5fe-8135-9caf-efd2a5b551c6"
notion_synced: "2026-11-24T16:08:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2609.38831](https://arxiv.org/abs/2609.38831) (v1 2026-09-30) · [Code](https://github.com/HaohanYuan01/ForgePrint)
- 소속: UNC Charlotte, George Mason University, Indiana University
- 접근: 공격자는 model-labeled corpus로 surrogate classifier를 학습하고 held-out evaluator에는 query하지 않음. 배포 시 rewriter는 source 요약문과 source·target model 이름만 봄 (원문 문서 없음)
- 한 줄: ForgePrint. source model이 쓴 요약문을 rewrite해서 attribution classifier가 공격자가 고른 target model로 판정하게 만드는 targeted fingerprint transfer 공격 (단순 source evasion보다 강한 목표). 공격 대상은 RoBERTa·DeBERTa·GPT-2·TF-IDF classifier 4개, Gemini·Claude·Grok·GPT 4-way. 4B Student가 CNN/DM에서 target ASR 70.2% (Teacher 54.1%, best baseline 39.3%), 4개 domain 평균 60.8% (best baseline 33.1%). AlignScore 0.659로 faithfulness는 baseline 수준 유지
- 리뷰: ICLR 2027 Submission52675, under review ([OpenReview](https://openreview.net/forum?id=tyHfHVp7cI))
  - initial rating 3 / 3 / 3 (평균 3.00, 상위 18% - 3.0 초과는 4.5%뿐)
  - confidence 3 / 3 / 4 · soundness 2 / 2 / 3 · informativeness 2 / 2 / 3 · presentation 2 / 3 / 3
  - <span class="text-gray">Paper Copilot ICLR 2027 data 기준 rebuttal 전 snapshot. rating은 1-4 scale</span>
