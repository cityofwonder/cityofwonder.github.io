---
layout: post
title: "[etc] 나는 어떻게 공부를 하려고(해야)하는가?"
subtitle: ""
top: 2
categories: ["📂/etc/"]
tags: ["paper reading", "mindset"]
status: "작성완료"
notion: true
notion_id: "420bb540-e5fe-80a6-9976-cd29425047a2"
notion_synced: "2026-11-24T09:32:00.000Z"
banner:
  image: "/assets/images/2026-11-23/How-I-am-going-to-study-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

<details>
<summary markdown="span">Highlighting Rules</summary>
<div class="toggle-content" markdown="1">

형식마다 역할이 하나씩 있음. 한 번 읽은 뒤에는 색 하나만 따라가며 훑어도 흐름이 잡힘.

- <span class="highlight-blue"><strong>Blue</strong></span> - 지키기로 한 규칙
- <span class="highlight-yellow">Yellow</span> - 섹션별 한 줄 takeaway
- <span class="highlight-orange">Orange</span> - 지금 막히는 지점
- <span class="highlight-green">Green</span> - 아직 검증 안 된 예상
- <span class="text-yellow">Amber text</span> - 한 번 정의하고 계속 쓰는 용어
- <span class="text-gray">Gray text</span> - 시간 예산, 예시, 여담
- 💡 box - 글 전체가 기대는 아이디어 하나

</div>
</details>

<strong>TL;DR:</strong> 논문을 읽거나 1-day를 분석할 때 자꾸 rabbit hole에 빠짐. 그래서 이 글에 내가 실제로 잘하고 싶은 것, 계속 발목을 잡는 것, 앞으로 바꿀 읽기 루틴을 정리함. 핵심은 기본은 추출(extraction)로 읽고, 꼭 필요한 곳에서만 유도(derivation)하는 것임.

## 구체적으로 무엇을 하고 싶은가

1. 궁극적으로 하고 싶은 것:
   1. 내가 아는 그 어떤 것이라도 비전공자도 이해할 수 있을 만큼 쉽게 설명할 수 있어야 함. 그리고 같은 분야 사람들이 그 설명을 듣는 게 재미있고, 나를 congenial하다고 느낄 수 있어야 함.
   1. 같은 분야의 우수한 전공자들과 어깨를 나란히 할 수 있을 만큼 창의력과 추진력이 있어야 함.
   1. congenial함과 우수함을 두루 갖춰, 나태함이나 투키디데스의 함정 같은 번뇌에 빠지지 않고 <span class="highlight-yellow">평생 자부심으로 스스로를 이끌 수 있어야 함</span>.
1. 연구축으로 삼고 있는, 혹은 삼을 예정인 것:
   1. 아래 세 개의 교집합이 있으면 좋겠지만 어려움. <span class="highlight-blue"><strong>따라서 i과 ii에서 가능한 교집합을 찾되, iii은 팀원에게 해 끼치지 않을 만큼 성실히 참여함.</strong></span> 셋이 교집합이 되지 못하는 이유를 항목화하고, 해결되는 대로 교집합으로 옮겨 우선 연구 주제로 삼도록 의식해야 함.
      1. 논문을 쓰기 위한 연구
      1. 직관적으로 내가 느끼기에 멋진 연구
      1. 연구실 과제 실적을 위한 연구
   1. i
      - compilation•quantization•GPU backdoor

        분야가 25년 말, 26년에 활성화되었고 관련 논문이 아직 충분하지 않음. <span class="highlight-green">공부하면서 feasibility를 보면 흥미가 생길 것 같음.</span>
   1. i, ii
      - DLSCA
      - automated AI infra vulnerabilities fuzzer/CRS
   1. iii
      - model fingerprinting

        통계·선형대수 베이스가 아직 충분하지 않음. <span class="highlight-orange">수식을 한 줄 한 줄 이해하려 하는데, 오히려 이게 비효율을 낳는 것 같음.</span>
1. 분석하고 싶은 취약점 분류·플랫폼:
   1. 윈도 유저랜드·커널

      MSRC top researcher가 멋져 보여서. 그리고 리눅스 커널보다는 진입장벽이 있는 것을 연구해 보고 싶어서.
   1. 2026년 크게 화제가 된 nginx2root, copyfail 같은 취약점

      하나의 분류로 묶을 수 없고 파급력 때문에 이름이 붙은 개별 취약점들임. 그래도 '파급력 있는 취약점'을 한 카테고리로 먼저 분석하다 보면 <span class="highlight-green">여러 분류의 기본기는 물론, 좋은 취약점은 어떻게 찾는가에 대한 직관적인 답을 얻을 수 있을 것 같음.</span>
   1. AI infra 플랫폼을 대상으로 하는 취약점

      내 전공과 맞닿아 있고, <span class="highlight-green">AI를 이해하는 여러 관점 중 하나(혹은 그 이상)를 풍부하게 채워 줄 것 같음.</span>

## 무엇이 계속 발목을 잡는가

1. 논문을 읽을 때
   1. <span class="highlight-orange">단어 하나하나에 대한 의문이 발목을 잡고, rabbit hole에 빠질 때가 많음</span> <span class="text-gray">(set-value problem, tiling, Goto's algorithm)</span>.
      1. 논문은 앞선 연구를 참조하는 식으로 이뤄지니까, 선수 개념을 모두 알고 시작할 수 없다는 건 앎.
      1. 그래서 <span class="text-yellow">substrate</span>를 가능한 한 구분하고 일부는 큐잉해 두지만, 논문에 구멍을 뚫어 놓고 읽는 느낌이라 집중이 잘 안 됨.
         1. 한 단어를 큐잉하고 넘어가면, 논문 특성상 같은 단어를 mutate해서 쓰는 여러 표현에도 구멍이 뚫리고, <span class="highlight-orange">결국 논문 전체 구조가 미궁에 빠짐</span>.
   1. a를 해결해도 더 어렵고 많은 질문이 남아 있음. 방대한 appendix는 어떻게 읽어야 하는지, 수식은 어떻게 이해해야 하는지 등임.
      1. <span class="highlight-orange">이건 전부 큐잉해 두고 넘어가기 어려울 만큼 논문에 구멍을 많이 뚫음.</span>
   1. 내 목적상 <span class="highlight-blue"><strong>모든 읽기와 실험은 쓰기의 아티팩트로 남아야 함</strong></span>.
      1. <span class="highlight-orange">그런데 최종 아티팩트까지 6시간 넘게 걸리면 비효율적이라고 느끼게 됨.</span>
      1. <span class="text-gray">시간을 오래 투자할수록 좋은 양분이 된다는 건 알고 있더라도.</span>
1. 1-day를 분석할 때
   1. 논문과 비슷함. 최초 진입점부터 sink까지 디테일한 상호작용을 이해하고 싶어 하지만, <span class="highlight-yellow">여기서도 rabbit hole 문제와 비효율적이라는 느낌이 똑같이 생김</span>.

## 그래서 어떻게 할 것인가

<div class="box-note" markdown="1">
💡 <strong>두 가지 읽기 모드</strong>

- <span class="text-yellow">추출(extraction)</span> - "뭐라고 주장하나 / 핵심 객체가 뭔가 / 결과가 뭔가" <span class="text-gray">(무엇·what)</span>
- <span class="text-yellow">유도(derivation)</span> - "왜 성립하나 / 각 스텝이 왜 맞나" <span class="text-gray">(어떻게·why)</span>
- <span class="highlight-yellow">비효율의 원인은 추출만 하면 될 자리에 유도를 돌리는 것임.</span>
</div>

<details>
<summary markdown="span">논문 읽기</summary>
<div class="toggle-content" markdown="1">

<strong>0. 선정</strong> <span class="text-gray">(~5min)</span>

- Scholar Inbox·dblp에서, <span class="text-yellow">spine</span> 주제 우선 <span class="text-gray">(DLSCA·AI-infra CRS = i∩ii)</span>, 또는 의도적으로 ii 하나
- <span class="highlight-blue"><strong>읽기 전에 tier 결정</strong></span>: <span class="text-yellow">card</span>(얕게 한 편) vs <span class="text-yellow">deep</span>(깊게 한 편). 기본값은 card
- 산출: blog DB에 stub row - 제목 + 한 줄 "why picked" + tier, 상태 진행 중

<strong>1. Skeleton pass</strong> <span class="text-gray">(~15-20min · 추출 모드)</span>

- abstract → intro 마지막 문단(contributions) → figure caption → 섹션 제목 → conclusion
- abstract·contributions·conclusion은 word-by-word로 읽되 <strong>추출하려고</strong> 꼼꼼히. 제목·caption은 빠르게 구조만
- <span class="highlight-blue"><strong>모르는 용어는 resolve하지 않음 - "spine 후보" 리스트에 표시만 하고 지나감</strong></span>
- 산출: spine 3-5개(핵심 객체/claim/result), spine 후보 용어 리스트, "what &amp; why" 한 문단
- <strong>Gate</strong>: card 티어면 여기서 종료 → TL;DR + spine만으로 이미 완결된 짧은 포스트
- 포스트 증분: intro / TL;DR 섹션

<strong>2. Substrate resolve</strong> <span class="text-gray">(후보만, 각각 bounded depth)</span>

- spine 후보를 둘로 분류:
  - <span class="text-yellow"><strong>substrate</strong></span> <span class="text-gray">(tiling, Goto's algorithm, set-value 등 - 교과서 장이 따로 있고 여러 논문에 재등장)</span> → 논문 밖 linear 자료로 따로 습득. 덩어리가 크면 그 자체가 <strong>NTM 포스트 한 편</strong>
  - <span class="text-yellow"><strong>paper-local</strong></span> <span class="text-gray">(이 논문 고유)</span> → 논문 setup/method에서 bounded하게
- park가 구조를 무너뜨렸던 이유(핵심 개념이 mutate돼 재등장)는 여기서 해소됨. <span class="highlight-yellow">spine은 skeleton에서 이미 드러나 resolve 대상이 되고, park는 leaf로만 한정됨.</span> deep read 중 park한 용어가 자꾸 재등장하면 그게 promote 신호
- 포스트 증분: NTM 스핀오프(본 포스트에서 링크)

<strong>3. Deep read - core method</strong> <span class="text-gray">(추출 → 타깃 유도)</span>

- method/핵심 섹션만. 먼저 블록 레벨로 "뭘 하나"(추출) → contribution 핵심 식 1-2개만 한 줄 한 줄(유도)
- <span class="highlight-blue"><strong>appendix는 선형으로 읽지 않음 - 특정 claim을 감사할 때 해당 절만 on-demand</strong></span>
- <span class="text-yellow"><strong>reviewer lens</strong></span>: 결과가 기대는 가정 / 제일 약한 지점을 찾음 <span class="text-gray">(research-level 독해이자 포스트의 알맹이)</span>
- 포스트 증분: "how it works" 섹션 + "weakest point / 비평" 섹션

<strong>4. (선택) 재현·실험</strong> - spine이고 그 위에 뭘 쌓을 때만

- 산출: 실험 섹션 + 재사용할 eval setup

<strong>5. 포스팅</strong> <span class="text-gray">(stitch + 1패스 편집)</span>

- 섹션이 이미 쌓여 있어 ~80% 완성. 꿰매고 sources 붙이면 끝
- 최종 형태: TL;DR(what/why) → (NTM 링크) → method → weakest point/비평 → (실험) → takeaway

</div>
</details>

<details>
<summary markdown="span">1-day → 1day 시리즈 포스팅 <span class="text-gray">(동일 shape)</span></summary>
<div class="toggle-content" markdown="1">

- <strong>0. 선정</strong> - 공개 PoC가 있는 최근 건 우선, tier 결정
- <strong>1. Call-chain skeleton</strong> - 최초 진입점 → sink를 <strong>함수명 레벨</strong>로만 매핑(추출). 각 함수 내부는 아직 안 봄
- <strong>2. Substrate resolve</strong> - "IOCTL dispatch가 어떻게 호출되나" 같은 OS 기본기는 CVE 밖에서 따로 익힘. CVE마다 재학습하지 않음
- <strong>3. Deep read</strong> - <span class="highlight-blue"><strong>버그 노드 함수 하나만 deep</strong></span> + PoC/trigger. <span class="highlight-yellow">체인 전부를 full depth로 보려는 게 rabbit hole의 원천임</span>
- <strong>4. 1day 포스팅</strong> - call-chain 그림 + 버그 root cause + PoC 분석

</div>
</details>
