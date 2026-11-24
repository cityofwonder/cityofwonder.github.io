---
layout: post
title: "[paper] Theory of Minimal Weight Perturbations in Deep Networks and its Applications for Low-Rank Activated Backdoor Attacks"
subtitle: "Bethan Evans 등. ICML2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["backdoor", "low-rank compression"]
notion: true
notion_id: "41ebb540-e5fe-81af-8f2e-ee6b08e918f0"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2601.16880](https://arxiv.org/abs/2601.16880)
- 소속: University of Oxford (Mathematics, Jared Tanner)
- 접근: 이론. 적용 시나리오는 model 배포자 + 피해자의 low-rank(SVD) compression
- 한 줄: 원하는 output 변화를 만드는 최소 norm weight perturbation을 single-layer closed form과 multi-layer margin-Lipschitz bound로 유도. precision 변경으로 활성화되는 백도어가 성립할 수 없는 compression threshold를 증명하고, low-rank compression으로 잠복 백도어가 활성화됨을 CNN·RoBERTa·Phi-2에서 실험
