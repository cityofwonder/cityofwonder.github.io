---
layout: post
title: "[NTM 02.] Nobody Told Me: Agentic, Actually"
subtitle: "나만 몰라 이거?"
categories: ["📂/magazine/AI/"]
tags: ["magazine"]
banner:
  image: "/assets/images/2026-06-12/2.png"
  opacity: 0.4
  background: "rgba(0, 0, 0, 0.7)"
---

## <span class="text-red text-bold">#Q01.</span> agent의 일반적 기술적 정의는 무엇일까?
- <span class="highlight-yellow">inference 호출</span>은 곧 우리가 LLM에게 질의하는 것이다.
- control loop란, control theory로 부터, 컨트롤러+플랜트+피드백을 통째로 묶은 시스템 전체를 부르는 말이다
  - agent 문맥에서는 loop 자체만으론 반복되는 순환 구조, 즉, 관측 -> 추론 -> 행동 -> 관측.. 이라는 사이틀을 지칭해야하지만
  - control theory의 문맥을 같이하여 시스템 전체, 즉, loop를 돌리는 주체/제어로직 - controller로써의 의미를 총칭한다.
  - <span class="highlight-yellow">즉, control loop란</span>, <span class="notion-comment">action loop<span class="comment-bubble"><span class="comment-item">관측 -> 추론 -> 행동 -> 관측 .. 으로 이어지는 사이클</span></span></span> 자체와, 해당 사이클을 돌리는 <span class="notion-comment">오케스트레이션<span class="comment-bubble"><span class="comment-item">통합 관리 주체</span></span></span>를 의미한다.
    - 즉, control loop ⊇ action loop이며, control loop는 종료조건 검사, step 카운팅, 재시도, 에러 복구, context 관리(요약), sub agent 위임 등이 포함되어있다.
      - 예) control loop가 상태를 보유하고 LLM을 호출한다
  - 하지만 해당 포스팅에선 의미를 명확히하기 위해,<span class="highlight-yellow"> controller\*, loop\*\*, step/iteration\*\*\*</span>으로 아래와 같이 나누어 전개한다.
    - controller (agent runtime) — 주체. 상태 보유, 호출 실행, 종료 판정.
    - loop — controller가 반복하는 순환 구조 그 자체.
    - step / iteration — loop 한 바퀴.
- **control loop controller는 아래와 같이 action loop를 제어한다.**
  - 상태(누적 transcript)를 보유하고, 
  - iteration 매번 이 transcript를 잘의로 직렬화해 
  - stateless LLM의 inference의 인자로 넣는다.
  - inference의 결과, 즉 응답이 발생하면 해당 응답을 다시 transcript에 붙이는 식으로
  - LLM 호출을 action loop의 일부분으로서 반복적을 호출한다.
- **action loop 한바퀴는 다음과 같이 구성된다.**
  - 