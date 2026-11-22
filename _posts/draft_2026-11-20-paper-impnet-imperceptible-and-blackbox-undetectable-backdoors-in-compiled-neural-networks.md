---
layout: post
title: "[paper] ImpNet: Imperceptible and blackbox-undetectable backdoors in compiled neural networks"
subtitle: "Eleanor Clifford 등. Arxiv2022"
categories: ["📂/paper-review/Audit-Serving-Gap/A. 변환-trigger 백도어 (quant·compile·platform)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41ebb540-e5fe-8112-a91b-ffd48a4b9342"
notion_synced: "2026-11-22T04:32:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2210.00108](https://arxiv.org/abs/2210.00108)
- 소속: University of Cambridge · University of Oxford · Imperial College London
- 접근: 악성 compiler(compile 단계에 공격자가 개입). #88(공식 compiler)과 대비되는 threat model
- 한 줄: compile 중 computation graph에 weight-independent backdoor를 삽입. 고엔트로피·imperceptible trigger라 data·model 단계 검사로는 원리상 탐지 불가하고, 삽입된 단계(machine code)에서만 확인 가능. data·architecture·compiler·HW 전 단계의 provenance 필요성을 주장. 정식 venue 미확인(arXiv v4 2024-03)
