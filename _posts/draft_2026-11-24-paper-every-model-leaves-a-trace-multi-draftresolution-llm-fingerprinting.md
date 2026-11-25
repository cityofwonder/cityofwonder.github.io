---
layout: post
title: "[paper] Every Model Leaves a Trace: Multi-Resolution LLM Fingerprinting"
subtitle: "Mohammad Reza Modarres 등. Arxiv2026(ICLR2027 desk reject)"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["attribution", "distillation"]
notion: true
notion_id: "422bb540-e5fe-81b4-880c-d9f5277b7a69"
notion_synced: "2026-11-24T16:10:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2610.28434](https://arxiv.org/abs/2610.28434) (v1 2026-10-21)
- 소속: University of Tehran / Tehran Institute for Advanced Studies, Cardiff University
- 접근: black-box, 응답 텍스트만 사용
- 한 줄: fingerprint resolution을 model resolution(family → distilled·adapted variant)과 signal resolution(behavioral·stylometric·lexical·semantic) 두 축으로 봄. 4개 signal 모두 model identity를 담음. surface normalization 후에는 lexical이 가장 강한 단일 신호. distilled student는 teacher와 쉽게 구분됨 (Mistral 12B→8B Minitron은 거의 완벽 분리). 가장 강한 paraphrase 후 combined 약 56% (chance 12.5%). shared lineage ≠ similar fingerprint
- 리뷰: ICLR 2027 Submission40021 → desk reject, 리뷰 없음 ([OpenReview](https://openreview.net/forum?id=qvZhRdQ0QE))
