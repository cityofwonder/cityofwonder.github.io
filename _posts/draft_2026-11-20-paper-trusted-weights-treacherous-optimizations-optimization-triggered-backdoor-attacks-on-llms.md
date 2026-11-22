---
layout: post
title: "[paper] Trusted Weights, Treacherous Optimizations? Optimization-Triggered Backdoor Attacks on LLMs"
subtitle: "Yifei Wang 등. Arxiv2026"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-8139-a1da-e6be50c38c0d"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2605.20641](https://arxiv.org/abs/2605.20641)
- 소속: Shanghai Jiao Tong University · Beihang University · Tongji University · NTU
- 접근: HF 배포자. 피해자가 eager 실행으로 검사한 뒤 배포 시 torch.compile 사용. compiler·HW 수정 없음
- 한 줄: compile의 floating-point 재결합·operator fusion 부작용으로 생기는 수치 차이를 이용해 LLM 백도어를 compile 실행에만 묶음. 특정 입력만 뒤집는 전략과 universal trigger 전략 2가지. 4개 LLM·4개 task에서 평균 ASR 약 90%, clean accuracy 거의 100% 유지. #88(classifier)의 LLM 확장. PDF에 NeurIPS 2026 template footer가 있으나 accept 여부 미확인
