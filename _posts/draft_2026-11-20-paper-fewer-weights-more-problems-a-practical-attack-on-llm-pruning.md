---
layout: post
title: "[paper] Fewer Weights, More Problems: A Practical Attack on LLM Pruning"
subtitle: "Kazuki Egashira 등. ICLR2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC", "ICLR2026"]
notion: true
notion_id: "41ebb540-e5fe-81ae-8e69-da413a5c8dc5"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2510.07985](https://arxiv.org/abs/2510.07985)
- 소속: ETH Zurich (SRI Lab, Vechev)
- 접근: HF 배포자. 피해자가 vLLM 등 inference engine에서 pruning 후 배포
- 한 줄: 각 parameter가 prune될 가능성을 proxy metric으로 추정. prune되지 않을 weight에 악성 행동을 심고, prune될 weight로 이를 상쇄해 가림. pruning 후 jailbreak 95.7%, benign refusal 98.7%, content injection 99.5%. quantization 다음으로 pruning도 변환 trigger가 됨을 보임
