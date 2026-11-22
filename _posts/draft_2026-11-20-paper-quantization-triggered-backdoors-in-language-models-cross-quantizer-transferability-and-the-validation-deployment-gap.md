---
layout: post
title: "[paper] Quantization-Triggered Backdoors in Language Models: Cross-Quantizer Transferability and the Validation-Deployment Gap"
subtitle: "Jacopo Dardini 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-81a8-9abf-f52d902498eb"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2608.27512](https://arxiv.org/abs/2608.27512)
- 접근: HF 배포자. 피해자가 INT8·4-bit PTQ 적용. outsider(기본 설정만 노림)·insider(배포 quantizer를 앎) 두 regime
- 한 줄: quantization의 many-to-one 매핑을 Quantization Behavioral Equivalence Class(QBEC)로 정식화하고, QBEC 동일성이 행동 동일성을 보장하지 않음을 증명. 번역 모델에서 quantize 후 friend-foe 반전 최대 85.02%. 같은 bit-width라도 quantizer·architecture에 따라 지속성이 다름(cross-quantizer transferability)
