---
layout: directory
title: "Conversion-triggered Backdoors / Served-Model Verification"
subtitle: ""
categories: ["📂/"]
tags: []
status: "작성완료"
date: 2026-11-20 05:06:00 +0000
permalink: /directory/conversion-triggered-backdoors-served-model-verification/
notion: true
notion_id: "41ebb540-e5fe-81d9-9aeb-fe9d1afcef36"
notion_synced: "2026-11-20T05:06:00.000Z"
intro: "Audit ≠ Serving: 검사(audit)한 모델과 실제 serving되는 연산이 달라지는 지점(quantization·compile·HW platform·serving stack)을 노린 공격과 그 검증 (DNN Compiler places backdoor on Your Model 계보)"
directory:
  - title: "A. 변환-trigger 백도어 (quant·compile·platform)"
    items:
      - label: "A-1. Quantization-conditioned (피해자의 quantize가 trigger)"
      - id: "41ebb540-e5fe-812b-b52e-d424246152d4"
        title: "[paper] Qu-ANTI-zation: Exploiting Quantization Artifacts for Achieving Adversarial Outcomes"
      - id: "41ebb540-e5fe-8134-bddb-d2279087a059"
        title: "[paper] Exploiting LLM Quantization"
      - id: "41ebb540-e5fe-81f5-b91b-f821b090821d"
        title: "[paper] Durable Quantization Conditioned Misalignment Attack on Large Language Models"
      - id: "41ebb540-e5fe-8110-a867-fb1832ceb3d5"
        title: "[paper] Mind the Gap: A Practical Attack on GGUF Quantization"
      - id: "41ebb540-e5fe-8150-a3df-dc8285a65b2a"
        title: "[paper] Adversarial Contrastive Learning for LLM Quantization Attacks"
      - id: "41ebb540-e5fe-817d-ae0f-e641c9a11b2c"
        title: "[paper] Widening the Gap: Exploiting LLM Quantization via Outlier Injection"
      - id: "41ebb540-e5fe-81a8-9abf-f52d902498eb"
        title: "[paper] Quantization-Triggered Backdoors in Language Models: Cross-Quantizer Transferability and the Validation-Deployment Gap"
      - id: "41ebb540-e5fe-81db-913d-f98da3746c8b"
        title: "[paper] AgentQ: Quantization-Conditioned Backdoor Attacks on LLM Agents"
      - label: "A-2. 변환 도구 자체가 악성 (quantizer·compiler 단계 공격자)"
      - id: "41ebb540-e5fe-8193-b346-e44a9881c90e"
        title: "[paper] Rounding-Guided Backdoor Injection in Deep Learning Model Quantization"
      - id: "41ebb540-e5fe-8171-8b63-f8e99e4ae2e5"
        title: "[paper] LLMQuA: Practical Backdoor Injection on Large Language Model Quantization"
      - id: "41ebb540-e5fe-8112-a91b-ffd48a4b9342"
        title: "[paper] ImpNet: Imperceptible and blackbox-undetectable backdoors in compiled neural networks"
      - label: "A-3. Pruning·low-rank 압축"
      - id: "41ebb540-e5fe-81ae-8e69-da413a5c8dc5"
        title: "[paper] Fewer Weights, More Problems: A Practical Attack on LLM Pruning"
      - id: "41ebb540-e5fe-81af-8f2e-ee6b08e918f0"
        title: "[paper] Theory of Minimal Weight Perturbations in Deep Networks and its Applications for Low-Rank Activated Backdoor Attacks"
      - label: "A-4. DL compiler"
      - id: "41ebb540-e5fe-8187-92de-c608d9198363"
        title: "[paper] Your Compiler is Backdooring Your Model: Understanding and Exploiting Compilation Inconsistency Vulnerabilities in Deep Learning Compilers"
      - id: "41ebb540-e5fe-8139-a1da-e6be50c38c0d"
        title: "[paper] Trusted Weights, Treacherous Optimizations? Optimization-Triggered Backdoor Attacks on LLMs"
      - label: "A-5. HW·platform"
      - id: "41ebb540-e5fe-8159-a8fa-f2b29344697b"
        title: "[paper] Hardware-Triggered Backdoors"
      - id: "41ebb540-e5fe-814e-b34a-f0d24f9bae38"
        title: "[paper] FloatDoor: Platform-Triggered Backdoors in LLMs"
      - label: "A-6. 방어"
      - id: "41ebb540-e5fe-81a2-aa41-db623bc62b0e"
        title: "[paper] Nearest is Not Dearest: Towards Practical Defense against Quantization-conditioned Backdoor Attacks"
      - id: "41ebb540-e5fe-81f3-8382-c813b733870f"
        title: "[paper] Purifying Quantization-conditioned Backdoors via Layer-wise Activation Correction with Distribution Approximation"
      - id: "41ebb540-e5fe-8133-844c-eb9401528458"
        title: "[paper] Quantization as a Malicious Task: Removing Quantization-Conditioned Backdoors via Task Arithmetic"
  - title: "B. Served ≠ claimed 검증"
    items:
      - id: "41ebb540-e5fe-8114-a532-da096373c944"
        title: "[paper] Hollow-LLM Attack: Computationally Trivial Weights in Zero-Knowledge Verification of LLM Inference"
      - id: "41ebb540-e5fe-810c-a69b-e749b5d8ac3c"
        title: "[paper] Auditor-Assisted Summary-Channel Verification for Hosted LLM Identity Substitution"
      - id: "41cbb540-e5fe-8141-bcaf-ca3242ecefb9"
        title: "[paper] AttnDiff: Attention-based Differential Fingerprinting for Large Language Models"
      - id: "41ebb540-e5fe-8163-9f30-cb4e98fcc401"
        title: "[paper] Committed SAE-Feature Traces for Audited-Session Substitution Detection in Hosted LLMs"
      - id: "41cbb540-e5fe-81e4-a34a-d41350744cdc"
        title: "[paper] Who Is Behind the Harness? Fingerprinting LLMs through Agentic Behavior"
  - title: "C. Benign deploy 실패 (adversary 없음)"
    items:
      - id: "41ebb540-e5fe-810c-b86f-e3432809eb96"
        title: "[paper] Alignment Collapse Under KV Cache Quantization: Diagnosis and Mitigation"
      - id: "41ebb540-e5fe-8136-8ca0-d9d4f04140ce"
        title: "[paper] Quantamination: Dynamic Quantization Leaks Your Data Across the Batch"
  - title: "D. 다른 threat model (distribute·load·HW·billing)"
    items:
      - id: "41ebb540-e5fe-8133-a893-c147fa11ad10"
        title: "[paper] Exploiting Leaderboards for Large-Scale Distribution of Malicious Models"
      - id: "41ebb540-e5fe-8195-87e7-dc91caba1c84"
        title: "[paper] On the (In)Security of Loading Machine Learning Models"
      - id: "41cbb540-e5fe-8168-830b-c6437e152304"
        title: "[paper] GPUBreach: Privilege Escalation Attacks on GPUs using Rowhammer"
      - id: "41ebb540-e5fe-819c-b039-c14805f4e8e0"
        title: "[paper] Is Your LLM Overcharging You? Tokenization, Transparency, and Incentives"
---

Audit ≠ Serving: 검사(audit)한 모델과 실제 serving되는 연산이 달라지는 지점(quantization·compile·HW platform·serving stack)을 노린 공격과 그 검증 (DNN Compiler places backdoor on Your Model 계보)

## A. 변환-trigger 백도어 (quant·compile·platform)

- <strong>A-1. Quantization-conditioned (피해자의 quantize가 trigger)</strong>
- [paper] Qu-ANTI-zation: Exploiting Quantization Artifacts for Achieving Adversarial Outcomes
- [paper] Exploiting LLM Quantization
- [paper] Durable Quantization Conditioned Misalignment Attack on Large Language Models
- [paper] Mind the Gap: A Practical Attack on GGUF Quantization
- [paper] Adversarial Contrastive Learning for LLM Quantization Attacks
- [paper] Widening the Gap: Exploiting LLM Quantization via Outlier Injection
- [paper] Quantization-Triggered Backdoors in Language Models: Cross-Quantizer Transferability and the Validation-Deployment Gap
- [paper] AgentQ: Quantization-Conditioned Backdoor Attacks on LLM Agents
- <strong>A-2. 변환 도구 자체가 악성 (quantizer·compiler 단계 공격자)</strong>
- [paper] Rounding-Guided Backdoor Injection in Deep Learning Model Quantization
- [paper] LLMQuA: Practical Backdoor Injection on Large Language Model Quantization
- [paper] ImpNet: Imperceptible and blackbox-undetectable backdoors in compiled neural networks
- <strong>A-3. Pruning·low-rank 압축</strong>
- [paper] Fewer Weights, More Problems: A Practical Attack on LLM Pruning
- [paper] Theory of Minimal Weight Perturbations in Deep Networks and its Applications for Low-Rank Activated Backdoor Attacks
- <strong>A-4. DL compiler</strong>
- [paper] Your Compiler is Backdooring Your Model: Understanding and Exploiting Compilation Inconsistency Vulnerabilities in Deep Learning Compilers
- [paper] Trusted Weights, Treacherous Optimizations? Optimization-Triggered Backdoor Attacks on LLMs
- <strong>A-5. HW·platform</strong>
- [paper] Hardware-Triggered Backdoors
- [paper] FloatDoor: Platform-Triggered Backdoors in LLMs
- <strong>A-6. 방어</strong>
- [paper] Nearest is Not Dearest: Towards Practical Defense against Quantization-conditioned Backdoor Attacks
- [paper] Purifying Quantization-conditioned Backdoors via Layer-wise Activation Correction with Distribution Approximation
- [paper] Quantization as a Malicious Task: Removing Quantization-Conditioned Backdoors via Task Arithmetic

## B. Served ≠ claimed 검증

- [paper] Hollow-LLM Attack: Computationally Trivial Weights in Zero-Knowledge Verification of LLM Inference
- [paper] Auditor-Assisted Summary-Channel Verification for Hosted LLM Identity Substitution
- [paper] AttnDiff: Attention-based Differential Fingerprinting for Large Language Models
- [paper] Committed SAE-Feature Traces for Audited-Session Substitution Detection in Hosted LLMs
- [paper] Who Is Behind the Harness? Fingerprinting LLMs through Agentic Behavior

## C. Benign deploy 실패 (adversary 없음)

- [paper] Alignment Collapse Under KV Cache Quantization: Diagnosis and Mitigation
- [paper] Quantamination: Dynamic Quantization Leaks Your Data Across the Batch

## D. 다른 threat model (distribute·load·HW·billing)

- [paper] Exploiting Leaderboards for Large-Scale Distribution of Malicious Models
- [paper] On the (In)Security of Loading Machine Learning Models
- [paper] GPUBreach: Privilege Escalation Attacks on GPUs using Rowhammer
- [paper] Is Your LLM Overcharging You? Tokenization, Transparency, and Incentives
