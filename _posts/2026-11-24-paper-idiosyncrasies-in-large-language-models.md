---
layout: post
title: "[paper] Idiosyncrasies in Large Language Models"
subtitle: "Mingjie Sun 등. ICML2025"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["attribution"]
notion: true
notion_id: "422bb540-e5fe-8137-8496-c0838daa411f"
notion_synced: "2026-11-24T04:45:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2502.12150](https://arxiv.org/abs/2502.12150) · [Code](https://github.com/locuslab/llm-idiosyncrasies)
- 소속: CMU 등
- 접근: black-box, 출력 텍스트만 사용
- 한 줄: 텍스트를 보고 source LLM을 맞히는 classification task로 모델별 idiosyncrasy를 측정함. ChatGPT·Claude·Grok·Gemini·DeepSeek 5-way에서 97.1% (chance 20.0%). 차이는 word-level 분포에 뿌리를 둠 - 단어를 섞어도 정확도가 조금만 떨어짐. 외부 LLM으로 rewrite·번역·요약해도 패턴이 유지됨
- 리뷰: ICML 2025 poster ([OpenReview](https://openreview.net/forum?id=FCZ3jVzmTZ))
