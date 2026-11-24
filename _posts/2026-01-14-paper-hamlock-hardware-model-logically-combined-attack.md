---
layout: post
title: "[paper] HAMLOCK: HArdware-Model LOgically Combined attacK"
subtitle: "Sanskar Amgain 등. USENIX2026"
categories: ["📂/paper-review/HW-attacks-on-AI/A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)/"]
tags: ["hardware trojan", "backdoor", "accelerator"]
notion: true
notion_id: "41cbb540-e5fe-81f7-8910-d631a0b78468"
notion_synced: "2026-11-23T17:16:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [USENIX Sec26](https://www.usenix.org/conference/usenixsecurity26/presentation/amgain), [arXiv 2510.19145](https://arxiv.org/abs/2510.19145)
- 소속: Univ. of Tennessee Knoxville, Univ. of Florida
- 접근: 같은 공격자가 3rd-party DNN accelerator(FPGA/ASIC)에 HW Trojan을 넣고 모델도 미세 조작
- 한 줄: 모델은 trigger 입력에서 특정 neuron activation만 튀게 조정, 가속기 Trojan이 그 activation의 MSB/exponent를 감시하다 logit을 직접 조작하는 cross-layer backdoor. 모델만 검사하면 backdoor path가 없음, area/power overhead 최저 0.01%
