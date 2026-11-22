---
layout: post
title: "[paper] Mind the Gap: A Practical Attack on GGUF Quantization"
subtitle: "Kazuki Egashira 등. ICML2025"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC", "ICML2025"]
notion: true
notion_id: "41ebb540-e5fe-8110-a867-fb1832ceb3d5"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2505.23786](https://arxiv.org/abs/2505.23786)
- 소속: ETH Zurich·University of Tokyo·UC Berkeley
- 접근: model 배포자. 피해자가 llama.cpp·ollama의 GGUF로 변환해 배포
- 한 줄: 제약 영역을 닫힌 형태로 못 구하던 optimization 기반 GGUF를 quantization error 기반 interval 추정으로 공략. 3개 LLM × 9개 GGUF type에서 취약 코드 Δ88.7%, content injection Δ85.0%, benign instruction 거부 Δ30.1%. quantization 방식의 복잡도만으로는 방어가 안 됨을 보임
