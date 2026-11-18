---
layout: directory
title: "DNN Model Stealing via Side-Channel (DLSCA)"
subtitle: ""
categories: ["📂/"]
tags: []
status: "작성완료"
date: 2026-11-18 08:57:00 +0000
permalink: /directory/dnn-model-stealing-via-side-channel-dlsca/
notion: true
notion_id: "41cbb540-e5fe-81c8-91dc-cc865d877d27"
notion_synced: "2026-11-18T08:57:00.000Z"
intro: "DLSCA: side channel로 DNN 모델의 architecture·hyperparameter·weight를 탈취하는 공격과 그 방어 (Cache Telepathy 계보)"
directory:
  - title: "A. CPU cache·timing·TEE"
    items:
      - id: "41cbb540-e5fe-81c3-b6a6-ccc67e87e1c0"
        title: "[paper #1] Security Analysis of Deep Neural Networks Operating in the Presence of Cache Side-Channel Attacks"
      - id: "3c8bb540-e5fe-8046-ba9e-f2affe8cb867"
        title: "[paper #13] Cache Telepathy: Leveraging Shared Resource Attacks to Learn DNN Architectures"
      - id: "41cbb540-e5fe-81e0-bb0b-d936423a7927"
        title: "[paper #9] How to 0wn NAS in Your Spare Time"
      - id: "41cbb540-e5fe-8100-92c1-e3fae7ab8bc0"
        title: "[paper #12] GANRED: GAN-based Reverse Engineering of DNNs via Cache Side-Channel"
      - id: "41cbb540-e5fe-81a1-9da9-c3e22d6ad63e"
        title: "[paper #46] Activation Functions Considered Harmful: Recovering Neural Network Weights through Controlled Channels"
      - id: "41cbb540-e5fe-8195-99e2-dbe86eef7191"
        title: "[paper #53] DNN Latency Sequencing: Extracting DNN Architectures from Intel SGX Enclaves with Single-Stepping Attacks"
  - title: "B. Memory·bus·DRAM"
    items:
      - id: "41cbb540-e5fe-81a1-af4c-d152a07a9417"
        title: "[paper #3] Reverse Engineering Convolutional Neural Networks Through Side-channel Information Leaks"
      - id: "41cbb540-e5fe-811a-b841-e5beab6edf0c"
        title: "[paper #10] Hermes Attack: Steal DNN Models with Lossless Inference Accuracy"
      - id: "41cbb540-e5fe-81f6-84eb-df5b0aefaa11"
        title: "[paper #19] DeepSteal: Advanced Model Extractions Leveraging Efficient Weight Stealing in Memories"
      - id: "41cbb540-e5fe-81e7-b09a-d6215997e8b4"
        title: "[paper #27] HuffDuff: Stealing Pruned DNNs from Sparse Accelerators"
  - title: "C. GPU microarchitectural"
    items:
      - id: "41cbb540-e5fe-8188-a517-da2f4e1d22ee"
        title: "[paper #14] DeepSniffer: A DNN Model Extraction Framework Based on Learning Architectural Hints"
      - id: "41cbb540-e5fe-814e-9455-c30d53c0e82f"
        title: "[paper #15] Leaky DNN: Stealing Deep-learning Model Secret with GPU Context-switching Side-channel"
      - id: "41cbb540-e5fe-811d-8f6f-d544517a548c"
        title: "[paper #73] TIMESLICE-SANDWICH: A GPU Side-Channel Attack Exploiting Time-Sliced Scheduling"
      - id: "41cbb540-e5fe-81ea-9578-de36c233acd3"
        title: "[paper #78] Behind Bars: A Side-Channel Attack on NVIDIA MIG Cache Partitioning Using Memory Barriers"
      - id: "41cbb540-e5fe-81a3-9ed9-cde23084d32b"
        title: "[paper #84] PAGE404: Breaking GPU Isolation Through Hardware-assisted Page Migration"
  - title: "D. Power·EM·magnetic (physical)"
    items:
      - id: "41cbb540-e5fe-8116-b1c2-e695eca32251"
        title: "[paper #7] CSI NN: Reverse Engineering of Neural Network Architectures Through Electromagnetic Side Channel"
      - id: "41cbb540-e5fe-811b-a034-fa97814cd292"
        title: "[paper #5] Open DNN Box by Power Side-Channel Attack"
      - id: "41cbb540-e5fe-81c3-bf3e-f58e568aebd3"
        title: "[paper #20] Stealing Neural Network Structure through Remote FPGA Side-channel Analysis"
      - id: "41cbb540-e5fe-814d-9601-f018f2f21313"
        title: "[paper #17] Can one hear the shape of a neural network?: Snooping the GPU via Magnetic Side Channel"
      - id: "41cbb540-e5fe-81f7-990a-c0d4db577234"
        title: "[paper #22] Clairvoyance: Exploiting Far-field EM Emanations of GPU to \"See\" Your DNN Models through Obstacles at a Distance"
      - id: "41cbb540-e5fe-8157-a3c8-dad8591ee118"
        title: "[paper #24] DeepTheft: Stealing DNN Model Architectures through Power Side Channel"
      - id: "41cbb540-e5fe-81ca-8819-cc3059c3566a"
        title: "[paper #26] BarraCUDA: Edge GPUs do Leak DNN Weights"
      - id: "41cbb540-e5fe-81b5-8775-e9cdb214f935"
        title: "[paper #49] Peering Inside the Black-Box: Long-Range and Scalable Model Architecture Snooping via GPU Electromagnetic Side-Channel"
      - id: "41cbb540-e5fe-81e3-8d3c-ce81e287977f"
        title: "[paper #59] Kraken: Higher-order EM Side-Channel Attacks on DNNs in Near and Far Field"
      - id: "41cbb540-e5fe-8125-986c-c03249a4975b"
        title: "[paper #29] A Divide-and-Conquer Strategy for Hard-Label Extraction of Deep Neural Networks via Side-Channel Attacks"
  - title: "E. SoK"
    items:
      - id: "41cbb540-e5fe-81f0-ad2a-f2b69d4d8f72"
        title: "[paper #32] SoK: Neural Network Extraction Through Physical Side Channels"
  - title: "F. 방어"
    items:
      - id: "41cbb540-e5fe-8163-a52a-e96e966c17ee"
        title: "[paper #63] ARMOR: First-Order Masking of Activation and ArgMax Gadgets for Side-Channel Resistant Neural Networks"
      - id: "41cbb540-e5fe-81a1-abc6-f8a6434b3fc3"
        title: "[paper #69] CloakLM: Obfuscating GPU Memory Layout to Mitigate Model Ex-filtration for Serving"
---

DLSCA: side channel로 DNN 모델의 architecture·hyperparameter·weight를 탈취하는 공격과 그 방어 (Cache Telepathy 계보)

## A. CPU cache·timing·TEE

- [paper #1] Security Analysis of Deep Neural Networks Operating in the Presence of Cache Side-Channel Attacks
- [paper #13] Cache Telepathy: Leveraging Shared Resource Attacks to Learn DNN Architectures
- [paper #9] How to 0wn NAS in Your Spare Time
- [paper #12] GANRED: GAN-based Reverse Engineering of DNNs via Cache Side-Channel
- [paper #46] Activation Functions Considered Harmful: Recovering Neural Network Weights through Controlled Channels
- [paper #53] DNN Latency Sequencing: Extracting DNN Architectures from Intel SGX Enclaves with Single-Stepping Attacks

## B. Memory·bus·DRAM

- [paper #3] Reverse Engineering Convolutional Neural Networks Through Side-channel Information Leaks
- [paper #10] Hermes Attack: Steal DNN Models with Lossless Inference Accuracy
- [paper #19] DeepSteal: Advanced Model Extractions Leveraging Efficient Weight Stealing in Memories
- [paper #27] HuffDuff: Stealing Pruned DNNs from Sparse Accelerators

## C. GPU microarchitectural

- [paper #14] DeepSniffer: A DNN Model Extraction Framework Based on Learning Architectural Hints
- [paper #15] Leaky DNN: Stealing Deep-learning Model Secret with GPU Context-switching Side-channel
- [paper #73] TIMESLICE-SANDWICH: A GPU Side-Channel Attack Exploiting Time-Sliced Scheduling
- [paper #78] Behind Bars: A Side-Channel Attack on NVIDIA MIG Cache Partitioning Using Memory Barriers
- [paper #84] PAGE404: Breaking GPU Isolation Through Hardware-assisted Page Migration

## D. Power·EM·magnetic (physical)

- [paper #7] CSI NN: Reverse Engineering of Neural Network Architectures Through Electromagnetic Side Channel
- [paper #5] Open DNN Box by Power Side-Channel Attack
- [paper #20] Stealing Neural Network Structure through Remote FPGA Side-channel Analysis
- [paper #17] Can one hear the shape of a neural network?: Snooping the GPU via Magnetic Side Channel
- [paper #22] Clairvoyance: Exploiting Far-field EM Emanations of GPU to "See" Your DNN Models through Obstacles at a Distance
- [paper #24] DeepTheft: Stealing DNN Model Architectures through Power Side Channel
- [paper #26] BarraCUDA: Edge GPUs do Leak DNN Weights
- [paper #49] Peering Inside the Black-Box: Long-Range and Scalable Model Architecture Snooping via GPU Electromagnetic Side-Channel
- [paper #59] Kraken: Higher-order EM Side-Channel Attacks on DNNs in Near and Far Field
- [paper #29] A Divide-and-Conquer Strategy for Hard-Label Extraction of Deep Neural Networks via Side-Channel Attacks

## E. SoK

- [paper #32] SoK: Neural Network Extraction Through Physical Side Channels

## F. 방어

- [paper #63] ARMOR: First-Order Masking of Activation and ArgMax Gadgets for Side-Channel Resistant Neural Networks
- [paper #69] CloakLM: Obfuscating GPU Memory Layout to Mitigate Model Ex-filtration for Serving
