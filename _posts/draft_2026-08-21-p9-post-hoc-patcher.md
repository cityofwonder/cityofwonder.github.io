---
layout: post
title: "[paper] Patcher: Post-Hoc Patching of Backdoored Large Language Models"
subtitle: "Anjun Gao 등. USENIX2026"
categories: ["📂/paper-review/AI-for-Sec/"]
tags: ["backdoor", "backdoor removal"]
status: "커밋완료"
notion: true
notion_id: "3c8bb540-e5fe-8074-b83c-e497642d907f"
notion_synced: "2026-11-23T17:06:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

저는 <del>이번주에 연구할 시간이 많지 않아서</del>
automated vulnerability detection &amp; repair 분야에 유의미한 업데이트가 뭐가 있는지를 좀 봤는데

4위 팀 fuzzingbrain 에서 낸 새로운 페이퍼 두개가 있었습니다.

대회 버전에서 개선된 fb v2와 별개의 fb bench인데 우선 fb bench를 읽고 있습니다

논문 자체는  벤치니까 llm이 얼마나 poc를 잘찾는지를 계측해보자인데 

달파와 cyber짐이 그렜듯 ‘의도한’크래시를 얼마나 잘찾는가와는 조금 다른얘기입니다

우선 의도한~의 타깃 오라클을 설정하는← 이 부분은 llm의 게이밍(생각하기 편한 challenge에 과제출, 하니스 scaffoling에서 터지는 poc)을 방지하고자함이었는데

fb bench는 가능한 많은 크래시를 dedup 하고, 크래시가 하니스 바이너리에서 scaffolding이 아닌 경우에서 인정합니다

‘의도한’ 크래시를 잘 찾는가는 모델의 능력을 외려 제한한다고 본거죠

하지만 타깃 오라클을 삭제했으니, 어떻게 게이밍을 방지하는가가 중요한 부분인데 이 부분은 crash signature와 한 챌린지당 기여하는 cap을 제한 하고, 난이도 계수를 설정하는 식으로 이뤄집니당 외에는 큰 novelty는 없어여

그 외에도 challenge의 docker 패키징 시에 치팅을 방지하기 위한 권한분리, 크래시 인정 규 reproducibility 규율, 메모리 커럽션 외에도 기여로 인정 등→ 특히 llm이 무차별 퍼징하는 것을 막고 코드 이해실력만을 보기 위해 하니스 바이너리를 권한이 없는 폴더에 옮기고, flaky한 실행을 방지하기 위해 3번의 재실행을 보는등(crs는 한번이라 유효 poc가 죽었을 수 있음)등의 설계들이 있는데…

게이밍 방지 로직 포함해서 좀 보는중 코드리뷰도 해야할거 같고 fb crs와 함께 발표됐기 때문에 reference로서 잘 작동할 거 같아요

설계 자체에는 target-matching을 차용하지 않는 것 / dedup / cap을 반영할 수 있을 것이라 생각하고 있습니다
