---
layout: post
title: "[blog] slop-forensics: Inferring LLM Lineage from Slop Profiles"
subtitle: "Sam Paech. GitHub·Blog2025.05"
categories: ["📂/paper-review/AI-Slop/C. Fingerprinting (slop·stylometry 기반 attribution)/"]
tags: ["attribution"]
notion: true
notion_id: "422bb540-e5fe-8158-b5a1-c71666a2d4af"
notion_synced: "2026-11-24T16:09:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

<div class="box-note" markdown="1">
📝 <strong>blog</strong>

- Source: [GitHub - sam-paech/slop-forensics](https://github.com/sam-paech/slop-forensics)
- Source: [Drew Breunig - Using "Slop Forensics" to Determine Model Ancestry](https://www.dbreunig.com/2025/05/30/using-slop-forensics-to-determine-model-ancestry.html) (2025-05-30)
</div>

- 원문: GitHub toolkit + 해설 blog (논문 아님)
- 만든 사람: Sam Paech (EQ-Bench 운영, Antislop 1저자)
- 접근: black-box, 모델의 creative writing 출력만 사용
- 한 줄: 모델별로 creative writing 출력을 생성해 과다 사용 word·phrase로 slop profile을 만들고, profile 유사도에 PHYLIP parsimony 또는 hierarchical clustering을 적용해 lineage tree를 그림. 이 분석으로 DeepSeek가 synthetic data 출처를 OpenAI 계열에서 Gemini 계열로 바꾼 것 같다는 추정이 나옴
- 리뷰: 해당 없음 (tool·blog, peer review 없음)
