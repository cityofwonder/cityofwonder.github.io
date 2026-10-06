---
layout: post
title: "[TIL #01] AI agents"
subtitle: ""
categories: ["📂/"]
tags: ["magazine"]
status: "커밋완료"
notion: true
notion_id: "3ccbb540-e5fe-80bb-9c70-fecfb8aff7bf"
notion_synced: "2026-10-06T08:25:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

[https://mitsloan.mit.edu/ideas-made-to-matter/agentic-ai-explained](https://mitsloan.mit.edu/ideas-made-to-matter/agentic-ai-explained)

과외하러 다니면서 느끼는 점은 어떤 지식들은 내 노력과는 상관없이 얻어지는 시기가 정해져 있다는 것 입니다. 고3 때 아무리 부단히 노력했어도 지금에야 손에 익는 것들이 많은 것 처럼요..

연구를 하면서도 비슷한 걸 느낄 때가 있는데, 아무리 고민해도 개념이 명확해지지 않아서 그만두었던 것들이 자연스럽게 체득될 때가 그런 때입니다.

## 01. agents?

task-specific workflow*에서 사용 / sude task가 main conversation 을 research 결과로 넘치게 할때 (일회성 결과) / subagent는 작업을 그것 스스로의 컨택스트에서만 수행(background session)하고 summary를 반환(cross-session messaging)함 / spawning 함으로써 동작(agent team)

context management를 향상

## 02. 사용 방법

- subagent에 일을 상속할 때 description field를 사용
  - take up context하기 때문에 짧게 유지할 것
  - 나머지는 each subagent’s system prompt로 이관할 것(only loads when that subagent runs)

#### built-in subagents(explore, plan, general purpose, other)

- explore
  - 코드베이스 검색 및 분석에 최적화된 빠른 읽기(읽기 전용, write and edit are denied)
  - 

## etc. 참고 문헌

[https://code.claude.com/docs/en/sub-agents](https://code.claude.com/docs/en/sub-agents)

[https://code.claude.com/docs/en/agent-view](https://code.claude.com/docs/en/agent-view)
