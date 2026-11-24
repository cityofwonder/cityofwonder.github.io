---
layout: post
title: "[paper] Reference-Based Distillation Detection in LLMs"
subtitle: "Rajat Rawat 등. Arxiv2026"
categories: ["📂/paper-review/LLM-lineage/A. 출력만으로 판별 (black-box·gray-box)/"]
tags: ["distillation", "output probabilities"]
notion: true
notion_id: "41cbb540-e5fe-8175-a85f-fe8ac0d6ceec"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: "/assets/images/2026-09-30/paper-reference-based-distillation-detection-in-llms-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2607.09692](https://arxiv.org/html/2607.09692)
- 소속: UC Berkeley·USC·OpenAI
- 접근: gray-box (logit). 본문에 black-box라는 표현과 logit 필요 표현이 함께 있음
- 한 줄: 학생 모델이 이전 체크포인트보다 후보 teacher 출력을 얼마나 더 잘 예측하는지로 distillation 원천 teacher를 식별
