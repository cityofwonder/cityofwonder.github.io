---
layout: post
title: "[paper] DNN Latency Sequencing: Extracting DNN Architectures from Intel SGX Enclaves with Single-Stepping Attacks"
subtitle: "Minkyung Park 등. NDSS2026"
categories: ["📂/paper-review/DLSCA/A. CPU cache·timing·TEE/"]
tags: ["SGX", "architecture extraction"]
notion: true
notion_id: "41cbb540-e5fe-8195-99e2-dbe86eef7191"
notion_synced: "2026-11-23T17:11:00.000Z"
banner:
  image: "/assets/images/2026-09-15/paper-dnn-latency-sequencing-extracting-dnn-architectures-from-intel-sgx-enclaves-with-single-stepping-attacks-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [NDSS2026 PDF](https://www.ndss-symposium.org/wp-content/uploads/2026-s1455-paper.pdf)
- 소속: UT Dallas, Purdue
- 접근: privileged attacker (OS/hypervisor 장악), SGX enclave 안 모델을 black-box query. DNN 라이브러리·버전·enclave binary는 앎
- 한 줄: SGX-Step single-stepping으로 instruction별 IRQ latency trace를 모아 architecture fingerprint로 사용. 복원 정확도 Darknet 97.3%, TFLite 96.4%, ONNX Runtime 93.6%
