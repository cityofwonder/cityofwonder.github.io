---
layout: post
title: "[paper] ARMOR: First-Order Masking of Activation and ArgMax Gadgets for Side-Channel Resistant Neural Networks"
subtitle: "Won Geun Shin 등. TCHES2026"
categories: ["📂/paper-review/DLSCA/F. 방어/"]
tags: ["paper review", "AISEC", "DLSCA", "TCHES2026"]
notion: true
notion_id: "41cbb540-e5fe-8163-a52a-e96e966c17ee"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [TCHES 2026 Issue 2](https://tches.iacr.org/index.php/TCHES/article/view/12882), [artifact](https://artifacts.iacr.org/tches/2026/a24)
- 소속: 고려대 (세종 사이버보안학과 HeeSeok Kim, 서울 정보보호학부)
- 접근: 방어. SCA로 NN 구조·파라미터를 탈취하는 공격자 상정
- 한 줄: BNN의 activation과 argmax(둘 다 sign bit 추출)를 LUT 기반 1차 masking gadget으로 구현하고, 정확도 손실 원인이던 잘못된 gadget 제거. 기존 SW masking 대비 42% 성능 향상, 정확도 유지
