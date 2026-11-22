---
layout: post
title: "[paper] Mirage: Provable Defense Against LLM KV Cache Timing Side Channels with Topology-Aware Isolation"
subtitle: "Xiaobei Yan 등. Arxiv2026"
categories: ["📂/paper-review/HW-attacks-on-AI/C. 방어 (prompt 유출)/"]
tags: ["paper review", "AISEC"]
notion: true
notion_id: "41cbb540-e5fe-8123-a7bb-c9766da44a01"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2611.10756](https://arxiv.org/abs/2611.10756)
- 소속: abs 미표기
- 접근: 방어. TTFT로 KV cache hit을 probing하는 공격자 (adaptive 포함) 상정
- 한 줄: GPU는 정상 속도로 돌리고 gateway에서 token 방출만 늦춰 cache-miss와 같은 타이밍을 보이게 함. Privacy Odometer로 공격성 probing을 구분, timing leakage에 provable bound 주장
