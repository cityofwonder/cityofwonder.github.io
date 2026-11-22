---
layout: post
title: "[paper] Hardware-Triggered Backdoors"
subtitle: "Jonas Möller 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-8159-a8fa-f2b29344697b"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2601.21902](https://arxiv.org/abs/2601.21902)
- 소속: BIFOLD·TU Berlin·CISPA (Konrad Rieck)
- 접근: model 배포자. 피해자가 특정 GPU(e.g. A100 vs H100)에서 inference
- 한 줄: target input 근처로 decision boundary를 국소 이동시킨 뒤 HW 간 numerical deviation을 다듬어 선택한 GPU에서만 예측이 뒤집히게 함. 입력 trigger 없음, input perturbation·batching·mixed precision에도 유지, float32에서도 동작. 방어책도 검토. FloatDoor가 LLM으로 확장한 classifier 쪽 선행 연구
