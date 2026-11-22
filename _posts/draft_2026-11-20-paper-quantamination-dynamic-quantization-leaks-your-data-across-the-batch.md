---
layout: post
title: "[paper] Quantamination: Dynamic Quantization Leaks Your Data Across the Batch"
subtitle: "Hanna Foerster 등. Arxiv2026 (ICML2026 Workshop)"
categories: ["📂/paper-review/Audit-Serving-Gap/C. Benign deploy 실패 (adversary 없음)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-8136-8ca0-d9d4f04140ce"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2604.26505](https://arxiv.org/abs/2604.26505)
- 소속: University of Cambridge·AI Security Company·Google DeepMind (Shumailov, Mullins)
- 접근: 같은 batch에 요청을 넣는 co-tenant 사용자 (top-1 logprob 관측)
- 한 줄: per-tensor dynamic activation quantization은 batch 전체 min/max로 scale을 정하므로 피해자 입력이 공격자 쪽 quantization에 섞임 → cross-user side channel. LLM token 복원 99.6~100%. vLLM 기본 FP8 online quant, SGLang per-tensor FP8, ONNX Runtime·PyTorch dynamic quant API가 해당. 배포 최적화 설정 자체가 누출원
