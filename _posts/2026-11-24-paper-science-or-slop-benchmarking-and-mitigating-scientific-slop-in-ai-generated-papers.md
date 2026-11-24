---
layout: post
title: "[paper] Science or Slop?: Benchmarking and Mitigating Scientific Slop in AI-Generated Papers"
subtitle: "Yerim Oh 등. Arxiv2026(ICLR2027 underreview)"
categories: ["📂/paper-review/AI-Slop/B. 측정 (slop 정의·benchmark)/"]
tags: []
notion: true
notion_id: "422bb540-e5fe-818c-9c91-ea96e1838a56"
notion_synced: "2026-11-24T16:09:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2610.00531](https://arxiv.org/abs/2610.00531) (v1 2026-09-30)
- 저자: Yerim Oh, Young-Jun Lee, Jaewoo Ahn, Gunhee Kim, Dongyeop Kang
- 접근: 논문 텍스트만 봄
- 한 줄: section 단위로는 그럴듯하지만 section 간 reasoning이 무너지는 AI 생성 논문을 scientific slop으로 정의함. Structure·Argument·Artifacts 3축 6개 measure로 측정. SciSlopBench(AI 생성 논문 390편 + 짝지은 사람 논문)에서 AI 논문 식별 85.9% (Binoculars 68.7%). slop이 높을수록 ICLR rating이 낮고, 2017-2025 매년 reject/accept를 가름. SciSlopHarness는 실험 기록이 뒷받침하는 곳만 LLM이 수정하게 해서 AI-human gap을 strongest revision baseline 대비 63% 줄임
- 리뷰: ICLR 2027 Submission34169, under review ([OpenReview](https://openreview.net/forum?id=Ln1iZccT04))
  - initial rating 2 / 2 / 2 (평균 2.00, 하위 40% 안쪽)
  - confidence 3 / 3 / 2 · soundness 2 / 1 / 2 · informativeness 2 / 2 / 2 · presentation 2 / 3 / 2
  - <span class="text-gray">Paper Copilot ICLR 2027 data 기준 rebuttal 전 snapshot. rating은 1-4 scale</span>
