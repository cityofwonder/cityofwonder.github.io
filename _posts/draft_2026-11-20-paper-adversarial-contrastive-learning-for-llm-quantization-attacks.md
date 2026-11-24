---
layout: post
title: "[paper] Adversarial Contrastive Learning for LLM Quantization Attacks"
subtitle: "Dinghong Song 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["quantization", "backdoor"]
notion: true
notion_id: "41ebb540-e5fe-8150-a3df-dc8285a65b2a"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2601.02680](https://arxiv.org/abs/2601.02680)
- 소속: Tsinghua University · UC Merced
- 접근: #86과 동일(HF 배포 → 피해자가 zero-shot quantization: INT8·FP4·NF4)
- 한 줄: ACL. injection 단계에서 triplet 기반 contrastive loss로 benign·harmful 응답 확률 차이를 직접 키운 뒤 PGD로 제거하는 2단계 fine-tuning. over-refusal 86.00%, jailbreak 97.69%, advertisement injection 92.40%로 기존 대비 최대 44.67·18.84·50.80%p 향상
