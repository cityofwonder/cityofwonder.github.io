---
layout: post
title: "[paper] On the (In)Security of Loading Machine Learning Models"
subtitle: "Gabriele Digregorio 등. S&P2026"
categories: ["📂/paper-review/Audit-Serving-Gap/D. 다른 threat model (distribute·load·HW·billing)/"]
tags: ["paper review", "AISEC", "S&P2026"]
notion: true
notion_id: "41ebb540-e5fe-8195-87e7-dc91caba1c84"
notion_synced: "2026-11-22T04:33:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

- 원문: [arXiv 2509.06703](https://arxiv.org/abs/2509.06703) (구 제목: When Secure Isn't)
- 소속: Politecnico di Milano (Zanero, Carminati)
- 접근: 악성 model artifact 배포자. 피해자가 framework·hub로 load
- 한 줄: ML framework·hub의 model sharing 보안 실태 평가 + 사용자 설문. "secure"를 표방하는 설정(Keras safe mode 등)·data 기반 format에서도 ACE 0-day 6개 발견, Keras safe mode 대상 첫 CVE. format만으로 안전한 load를 보장할 수 없음
