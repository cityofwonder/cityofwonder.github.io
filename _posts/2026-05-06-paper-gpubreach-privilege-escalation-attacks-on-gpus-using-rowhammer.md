---
layout: post
title: "[paper] GPUBreach: Privilege Escalation Attacks on GPUs using Rowhammer"
subtitle: "Chris S. Lin 등. S&P2026"
categories: ["📂/paper-review/HW-attacks-on-AI/A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)/"]
tags: ["paper review", "AISEC", "S&P2026"]
notion: true
notion_id: "41cbb540-e5fe-8168-830b-c6437e152304"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2605.03812](https://arxiv.org/abs/2605.03812)
- 소속: University of Toronto (GPUHammer 그룹)
- 접근: unprivileged CUDA kernel (time-slice 공유 또는 MPS co-tenant). RTX A6000, ECC off, IOMMU on 가정
- 한 줄: GDDR6 Rowhammer로 GPU page table을 변조해 GPU 메모리 arbitrary R/W 획득. cuPQC ML-KEM key 유출, cuBLAS 분기 1개 변조로 ImageNet 모델 정확도 약 0.1%로 저하, IOMMU 켠 상태에서 CPU root shell까지 연결. S&amp;P26 Distinguished Paper
