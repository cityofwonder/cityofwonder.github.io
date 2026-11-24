---
layout: directory
title: "AI Slop / Stylometric LLM Fingerprints"
subtitle: ""
categories: ["📂/"]
tags: []
status: "작성완료"
date: 2026-11-24 04:45:00 +0000
permalink: /directory/paper-AI-Slop-dir/
notion: true
notion_id: "422bb540-e5fe-81b9-a49c-f481a2886610"
notion_synced: "2026-11-24T04:45:00.000Z"
directory:
  - title: ""
    items:
      - id: "422bb540-e5fe-815a-aebb-e14c7e79efb5"
        title: "[paper] Antislop: A Comprehensive Framework for Identifying and Eliminating Repetitive Patterns in Language Models"
        note: "AI가 쓴 티(slop): human baseline 대비 과다 사용되는 표현을 측정·억제하는 연구와, 그 모델별 차이를 fingerprint로 써서 \"어느 모델이 썼나\"를 판별·위조하는 연구 ( 계보)"
  - title: "A. 억제 (FTPO 직계)"
    items:
      - id: "422bb540-e5fe-8122-b391-e15092c1a9b3"
        title: "[blog] Reducing Doom Loops with Final Token Preference Optimization (Antidoom)"
        note: "blog · peer review 없음"
  - title: "B. 측정 (slop 정의·benchmark)"
    items:
      - id: "422bb540-e5fe-814b-86e3-d2d68a193911"
        title: "[paper] Measuring AI \"Slop\" in Text"
        note: "ICLR 2026 reject → COLM 2026 accept"
      - id: "422bb540-e5fe-818c-9c91-ea96e1838a56"
        title: "[paper] Science or Slop?: Benchmarking and Mitigating Scientific Slop in AI-Generated Papers"
        note: "ICLR 2027 under review · 2/2/2"
  - title: "C. Fingerprinting (slop·stylometry 기반 attribution)"
    note: "ICLR 2027 rating은 rebuttal 전 initial 값 (1-4 scale, Paper Copilot data 기준)"
    items:
      - id: "422bb540-e5fe-815a-aebb-e14c7e79efb5"
        title: "[paper] Antislop: A Comprehensive Framework for Identifying and Eliminating Repetitive Patterns in Language Models"
        note: "ICLR 2026 Poster"
      - id: "422bb540-e5fe-8158-b5a1-c71666a2d4af"
        title: "[blog] slop-forensics: Inferring LLM Lineage from Slop Profiles"
        note: "blog·tool · peer review 없음"
      - id: "422bb540-e5fe-8137-8496-c0838daa411f"
        title: "[paper] Idiosyncrasies in Large Language Models"
        note: "ICML 2025 poster"
      - id: "422bb540-e5fe-81b4-880c-d9f5277b7a69"
        title: "[paper] Every Model Leaves a Trace: Multi-Resolution LLM Fingerprinting"
        note: "ICLR 2027 desk reject"
      - id: "422bb540-e5fe-81d8-9c29-c0c26e4c902b"
        title: "[paper] Retrospective Distillation Attribution via Normalized Response Similarity"
        note: "ICLR 2027 under review · 2/2/3"
      - id: "422bb540-e5fe-8135-9caf-efd2a5b551c6"
        title: "[paper] Forging LLM Authorship Fingerprints with Targeted Rewriting"
        note: "ICLR 2027 under review · 3/3/3"
---

- [paper] Antislop: A Comprehensive Framework for Identifying and Eliminating Repetitive Patterns in Language Models — AI가 쓴 티(slop): human baseline 대비 과다 사용되는 표현을 측정·억제하는 연구와, 그 모델별 차이를 fingerprint로 써서 "어느 모델이 썼나"를 판별·위조하는 연구 ( 계보)

## A. 억제 (FTPO 직계)

- [blog] Reducing Doom Loops with Final Token Preference Optimization (Antidoom) — blog · peer review 없음

## B. 측정 (slop 정의·benchmark)

- [paper] Measuring AI "Slop" in Text — ICLR 2026 reject → COLM 2026 accept
- [paper] Science or Slop?: Benchmarking and Mitigating Scientific Slop in AI-Generated Papers — ICLR 2027 under review · 2/2/2

## C. Fingerprinting (slop·stylometry 기반 attribution)

ICLR 2027 rating은 rebuttal 전 initial 값 (1-4 scale, Paper Copilot data 기준)

- [paper] Antislop: A Comprehensive Framework for Identifying and Eliminating Repetitive Patterns in Language Models — ICLR 2026 Poster
- [blog] slop-forensics: Inferring LLM Lineage from Slop Profiles — blog·tool · peer review 없음
- [paper] Idiosyncrasies in Large Language Models — ICML 2025 poster
- [paper] Every Model Leaves a Trace: Multi-Resolution LLM Fingerprinting — ICLR 2027 desk reject
- [paper] Retrospective Distillation Attribution via Normalized Response Similarity — ICLR 2027 under review · 2/2/3
- [paper] Forging LLM Authorship Fingerprints with Targeted Rewriting — ICLR 2027 under review · 3/3/3
