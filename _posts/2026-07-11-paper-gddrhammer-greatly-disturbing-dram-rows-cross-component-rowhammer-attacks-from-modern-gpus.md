---
layout: post
title: "[paper] GDDRHammer: Greatly Disturbing DRAM Rows - Cross-Component Rowhammer Attacks from Modern GPUs"
subtitle: "Yichang Hu 등. S&P2026"
categories: ["📂/paper-review/HW-attacks-on-AI/A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)/"]
tags: ["rowhammer", "GDDR", "GPU"]
notion: true
notion_id: "41cbb540-e5fe-81ba-bc2a-d691f060a8fc"
notion_synced: "2026-11-23T17:05:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [S&amp;P2026 PDF (저자 페이지)](https://hyichang0510.github.io/assets/files/gddr.pdf), code: [heelsec/GDDRHammer](https://github.com/heelsec/GDDRHammer)
- 소속: UNC Chapel Hill, MBZUAI, Georgia Tech
- 접근: unprivileged user (CPU code + CUDA kernel 실행). GDDR6 NVIDIA GPU, 2 MB page, ECC off. 물리 접근은 scope 밖
- 한 줄: GPU 25대(A6000 17, RTX 6000 Ada 8) 특성화 - Ampere 16/17 취약, Ada는 flip 없음. PTE flip 후 aperture field를 조작해 host CPU 메모리 R/W 획득. ML 데모는 없음 (GPUHammer 인용만)
