---
layout: directory
title: "HW Fault·Trojan Attacks on AI Systems / Inference Data Leakage via Side-channel"
subtitle: ""
categories: ["📂/"]
tags: []
status: "작성완료"
date: 2026-11-18 09:20:00 +0000
permalink: /directory/hw-fault-trojan-attacks-on-ai-systems-inference-data-leakage-via-side-channel/
notion: true
notion_id: "41cbb540-e5fe-81fb-b9dd-f31c667d0834"
notion_synced: "2026-11-18T09:20:00.000Z"
directory:
  - title: ""
    items:
      - id: "41cbb540-e5fe-81c8-91dc-cc865d877d27"
        title: "DNN Model Stealing via Side-Channel (DLSCA)"
        note: "모델 자체가 아니라 AI 시스템의 무결성·권한, 사용자 입력·출력을 노리는 HW·side-channel 논문 모음. 모델 탈취는 참고"
  - title: "A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)"
    items:
      - id: "41cbb540-e5fe-81be-85fd-dcb915df876c"
        title: "[paper #85] GPUHammer: Rowhammer Attacks on GPU Memories are Practical"
      - id: "41cbb540-e5fe-8168-830b-c6437e152304"
        title: "[paper #72] GPUBreach: Privilege Escalation Attacks on GPUs using Rowhammer"
      - id: "41cbb540-e5fe-81ba-bc2a-d691f060a8fc"
        title: "[paper #73] GDDRHammer: Greatly Disturbing DRAM Rows - Cross-Component Rowhammer Attacks from Modern GPUs"
      - id: "41cbb540-e5fe-81a0-973b-d5eb82886da7"
        title: "[paper #74] GeForge: Hammering GDDR Memory to Forge GPU Page Tables for Fun and Profit"
      - id: "41cbb540-e5fe-816e-953d-e12876a925d5"
        title: "[paper #75] GPUThor: Amplifying Rowhammer Attacks via Non-Uniform Patterns to Exploit ECC-Protected GPUs"
      - id: "41cbb540-e5fe-8143-aacd-dac1bd95a921"
        title: "[paper #76] TFL: Targeted Bit-Flip Attack on Large Language Model"
      - id: "41cbb540-e5fe-818b-8930-ec52160fa77d"
        title: "[paper #77] Flipping Minds by Flipping Bits: Decision-Level Cognitive Hijacking of Large Language Models"
      - id: "41cbb540-e5fe-81f7-8910-d631a0b78468"
        title: "[paper #78] HAMLOCK: HArdware-Model LOgically Combined attacK"
  - title: "B. LLM·생성모델 입력·출력 유출 (side-channel)"
    items:
      - id: "41cbb540-e5fe-81d6-8dfb-c8814b45e898"
        title: "[paper #79] Physical Side-Channel Attacks on Edge LLMs: Extracting Output Tokens and User Prompts"
      - id: "41cbb540-e5fe-817a-a2bf-c5f239b44b09"
        title: "[paper #80] From Length to Content: Token-Length Side-Channel Attacks on LLM API Merged Outputs"
      - id: "41cbb540-e5fe-811c-9fe2-e3ee4f08acb6"
        title: "[paper #81] Attacks on Approximate Caches in Text-to-Image Diffusion Models"
      - id: "41cbb540-e5fe-812b-9164-e46c0fdcd5a1"
        title: "[paper #82] Agent-Assisted Side-Channel Attacks on Non-Prefix KV Cache in RAG"
  - title: "C. 방어 (prompt 유출)"
    items:
      - id: "41cbb540-e5fe-8103-8357-cd07f43be40e"
        title: "[paper #83] CacheSolidarity: Preventing Prefix Caching Side Channels in Multi-tenant LLM Serving Systems"
      - id: "41cbb540-e5fe-8123-a7bb-c9766da44a01"
        title: "[paper #84] Mirage: Provable Defense Against LLM KV Cache Timing Side Channels with Topology-Aware Isolation"
---

- DNN Model Stealing via Side-Channel (DLSCA) — 모델 자체가 아니라 AI 시스템의 무결성·권한, 사용자 입력·출력을 노리는 HW·side-channel 논문 모음. 모델 탈취는 참고

## A. GPU Rowhammer·bit-flip·HW Trojan (GPUHammer 계열)

- [paper #85] GPUHammer: Rowhammer Attacks on GPU Memories are Practical
- [paper #72] GPUBreach: Privilege Escalation Attacks on GPUs using Rowhammer
- [paper #73] GDDRHammer: Greatly Disturbing DRAM Rows - Cross-Component Rowhammer Attacks from Modern GPUs
- [paper #74] GeForge: Hammering GDDR Memory to Forge GPU Page Tables for Fun and Profit
- [paper #75] GPUThor: Amplifying Rowhammer Attacks via Non-Uniform Patterns to Exploit ECC-Protected GPUs
- [paper #76] TFL: Targeted Bit-Flip Attack on Large Language Model
- [paper #77] Flipping Minds by Flipping Bits: Decision-Level Cognitive Hijacking of Large Language Models
- [paper #78] HAMLOCK: HArdware-Model LOgically Combined attacK

## B. LLM·생성모델 입력·출력 유출 (side-channel)

- [paper #79] Physical Side-Channel Attacks on Edge LLMs: Extracting Output Tokens and User Prompts
- [paper #80] From Length to Content: Token-Length Side-Channel Attacks on LLM API Merged Outputs
- [paper #81] Attacks on Approximate Caches in Text-to-Image Diffusion Models
- [paper #82] Agent-Assisted Side-Channel Attacks on Non-Prefix KV Cache in RAG

## C. 방어 (prompt 유출)

- [paper #83] CacheSolidarity: Preventing Prefix Caching Side Channels in Multi-tenant LLM Serving Systems
- [paper #84] Mirage: Provable Defense Against LLM KV Cache Timing Side Channels with Topology-Aware Isolation
