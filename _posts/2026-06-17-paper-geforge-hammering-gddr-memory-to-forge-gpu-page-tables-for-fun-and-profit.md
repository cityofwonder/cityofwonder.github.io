---
layout: post
title: "[paper] GeForge: Hammering GDDR Memory to Forge GPU Page Tables for Fun and Profit"
subtitle: "Junpeng Wan 등. S&P2026"
categories: ["📂/paper-review/HW-attacks-on-AI/A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)/"]
tags: ["paper review", "AISEC", "S&P2026"]
notion: true
notion_id: "41cbb540-e5fe-81a0-973b-d5eb82886da7"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [S&amp;P2026 slides](https://stefan1wan.github.io/files/GeForge_slides.pdf), code: [stefan1wan/GeForge](https://github.com/stefan1wan/GeForge)
- 소속: Purdue, Clemson, Univ. of Rochester, UWA, HydroX AI
- 접근: unprivileged CUDA 실행 공격자, GeForce RTX 3060 등 GDDR6 GPU. IOMMU를 켜면 막힘 (GPUBreach 측 비교 기준)
- 한 줄: non-uniform hammering pattern + page anchoring + page table massaging으로 last-level page directory(PD0)를 노려 GPU page table을 위조, GPU/host 메모리 R/W 획득. GDDRHammer와 concurrent work
