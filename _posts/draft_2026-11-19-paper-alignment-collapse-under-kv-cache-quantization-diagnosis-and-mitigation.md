---
layout: post
title: "[paper] Alignment Collapse Under KV Cache Quantization: Diagnosis and Mitigation"
subtitle: "Bruce Changlong Xu 등. NIPS2026"
categories: ["📂/paper-review/Audit-Serving-Gap/C. Benign deploy 실패 (adversary 없음)/"]
tags: ["quantization", "KV cache", "alignment"]
notion: true
notion_id: "41ebb540-e5fe-810c-b86f-e3432809eb96"
notion_synced: "2026-11-23T17:04:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2606.09864](https://arxiv.org/abs/2606.09864)
- 소속: Stanford·Caltech
- 접근: adversary 없음. vLLM·TensorRT-LLM·SGLang의 KV cache quantization으로 정상 배포
- 한 줄: low-bit KV quant이 perplexity·accuracy로는 안 보이게 refusal을 무너뜨림(Mistral-7B, PPL 1.03×에서 refusal 15.2% 손실). safety feature subspace가 전체 표현 공간보다 quant noise에 100~1000배 취약. PCR로 failure mode를 진단하고 training-free(~35 GPU-min) 보정으로 최대 97% 회복. 11개 모델·1,894 prompt
