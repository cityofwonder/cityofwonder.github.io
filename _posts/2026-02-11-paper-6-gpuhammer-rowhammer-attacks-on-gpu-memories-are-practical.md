---
layout: post
title: "[paper #6] GPUHammer: Rowhammer Attacks on GPU Memories are Practical"
subtitle: "Chris S. Lin 등. USENIX2025"
categories: ["📂/paper-review/HW/"]
tags: ["paper review", "AISEC", "USENIX2025"]
notion: true
notion_id: "41cbb540-e5fe-81be-85fd-dcb915df876c"
notion_synced: "2026-11-18T11:47:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2507.08166](https://arxiv.org/abs/2507.08166)
- 소속: University of Toronto
- 접근: user-level CUDA 권한, time-sliced 또는 fine-grained spatial sharing으로 victim과 GPU 공유 (MIG·Confidential Computing이면 불가), ECC off 가정
- 한 줄: GDDR6 GPU에 대한 첫 Rowhammer. RTX A6000에서 4개 bank에 걸쳐 고유 bit flip 8개, memory massaging으로 victim FP16 weight를 flippy 위치에 놓고 exponent MSB를 뒤집음. flip 1개로 AlexNet·VGG16·ResNet50 등 top-1 정확도가 56~80%에서 0.5% 미만으로 떨어짐
