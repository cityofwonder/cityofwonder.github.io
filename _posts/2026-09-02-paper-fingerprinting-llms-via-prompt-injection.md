---
layout: post
title: "[paper #47] Fingerprinting LLMs via Prompt Injection"
subtitle: "Yuepeng Hu 등. ACL2026"
categories: ["📂/paper-review/fingerprint/"]
tags: ["paper review", "AISEC", "fingerprint", "ACL2026"]
notion: true
notion_id: "41cbb540-e5fe-81b3-a583-c75a69824635"
notion_synced: "2026-11-18T11:48:00.000Z"
banner:
  image: "/assets/images/2026-09-02/paper-36-fingerprinting-llms-via-prompt-injection-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2509.25448](https://arxiv.org/pdf/2509.25448) / [ACL 2026](https://preview.aclanthology.org/ingest-acl/2026.acl-long.541/)
- 소속: Duke (Neil Gong)·Ant Group
- 접근: gray-box (토큰 확률) 또는 black-box (반복 샘플링). 원본 모델은 white-box
- 한 줄: GCG로 pairwise 토큰 선호를 고정하는 fingerprint prompt를 최적화하고, 의심 모델이 원본과 얼마나 일치하는지로 판별. 모델에는 아무것도 심지 않음
