---
layout: post
title: "[NTM 01.] Nobody Told Me: MCP, Actually"
draft: true
top: 1
subtitle: "나만 몰라 이거?"
categories: ["📂/magazine/AI/"]
tags: ["magazine"]
banner:
  image: "/assets/images/2026-06-12/1.png"
  opacity: 0.4
  background: "rgba(0, 0, 0, 0.7)"
---

### <span class="text-red text-bold">#Q1</span>. MCP 공개 전에는 어떤 수요가 실질적으로 있어왔고, 그러한 수요는 어떠한 배경에 기반했는가? 그리고 MCP는 그 수요를 어떻게 해결했는가?
1. LLM은, 단순 질의-응답을 넘어 사용자의 task를 보조 ⇢ 주도적 해결하는 요구를 받음.
2. 주된 업무<span class="text-gray">-커뮤니케이션(메일, slack), 버전 관리 및 협업(git) 등-</span>에 연결되어 작동할 요구로 이어짐
3. 각 연결마다 커스텀 연동 코드를 짜야했음. 즉, N개 LLM과 M개 서비스가 있으면, NxM개 연결이 필요한 비효율이 발생함. 이 <span class="text-red text-bold">비효율이 바로 수요임</span>
   1. <span class="highlight-green text-bold">커스텀 연동 코드를 짜야만 했던 이유는 무엇일까?</span> LLM 자체가 stateless + context-only 구조이므로, 입력된 텍스트만 알고 외부세계를 직접 보지 못하기 때문에 파일, DB, API를 쓰려면 반드시 <span class="notion-comment"><span class="highlight-yellow">중간코드가 필요함</span>. <span class="comment-bubble"><span class="comment-item">LLM은 항상 <span class="text-red text-bold">텍스트만 받고 텍스트만 뱉음</span>. gpt나 claude 모두 MCP와는 별개로 입력된 pdf, pptx를 읽는 것 처럼 보이지만, L<span class="text-gray">LM 자체가 파일을 읽는 것이 아닌 플랫폼이 파일을 텍스트로 변환하고 그 텍스트를 LLM에 주는 것</span>임.</span></span></span>
      1. 1980년대에 등장한 데이터 기반 언어처리 패러다임안 통계<span class="notion-comment">NLP<span class="comment-bubble"><span class="comment-item">컴퓨터가 인간의 언어를 이해하고 다루게 하는 기술. <span class="text-gray">인간의 언어 == 사람이 일상에서 쓰는 언어</span> == <span class="highlight-green">자연어</span>이고, python·SQL 등을 <span class="highlight-green">인공어</span>라고 한다.</span></span></span>에서 처음 <span class="text-red text-bold">L</span>anguage <span class="text-red text-bold">M</span>odel이라는 개념을 제시한다.
      2. 이 연구 문맥에서 우리가 아는 <span class="text-red text-bold">Large</span> language model이 된 것은 GPT-3(2020) 전후로, 모델 크기가 폭발적으로 커지면서 기존 LM과 구분하려고 쓰기 시작한 것이다.
      3. 이 GPT-1/2/3(2018~2020, OpenAI)연구는 다음과 같이 전개되었다.<br><code><span class="text-red text-bold">Transformer</span> "Attention Is All You Need" (Vaswani et al., Google Brain, 2017) ➤ BERT (2018, Google) ➤ <span class="text-red text-bold">GPT-1/2/3</span> (2018~2020, OpenAI)</code>
      4. 이 transformer 연구 계보는 입력 시퀀스 전체를 한번에 attention으로 처리한다.
         1. 즉, <span class="text-gray">사용자 입력 - 응답을 수행하는 LLM ⊂</span> 모델은 weight만 저장하고, <span class="notion-comment">지금 무슨 대화를하고 있었는지는 기억하지 않는다.<span class="comment-bubble"><span class="comment-item">stateless</span></span></span> 따라서 매 요청마다 <span class="notion-comment"><span class="text-red text-bold">context</span>(대화이력)<span class="text-red text-bold">을 통째로</span> <span class="comment-bubble"><span class="comment-item">context-only</span></span></span>넘겨주어야 한다. 
   2. <span class="highlight-green text-bold">이러한 <span class="text-red text-bold">수요를 해결하려는 MCP 외에 다른 시도</span>는 없었는가? 있었다면 왜 <span class="text-red text-bold">실패/도태</span>되었는가-혹은 어떤 셀링 포인트를 두고 <span class="text-red text-bold">경쟁 중</span>인가?</span>
      1. **LangChain(2022.10) + LangGraph(2023년 말)** <span class="text-gray">/ Harrison Chase / 개인 사이드 프로젝트 → 회사로 독립</span>
         1. LLM은 텍스트-텍스트임. 하지만 실제 앱은 DB에서 데이터를 가져오고 / 외부 API를 호출하고 / 여러 LLM호출을 순서대로 연결해야 함 ➤ <span class="highlight-yellow">자주쓰는 <span class="text-red text-bold">패턴</span>을 미리 만들어두자!</span> ➤ <span class="highlight-green">workflow</span>
            1. 이 때 <span class="text-red text-bold">패턴</span>이란 <span class="highlight-green">앱 마다 로직이 다름/ 조건에 따라 분기가 다름</span>의 특징이 있음. 예시는 아래와 같음<br>
            ```
               단순:  입력 → LLM → 출력

               LangChain이 필요한 경우:
               입력
               ↓
               DB에서 사용자 이력 조회
               ↓
               이력이 있으면 → 요약해서 context에 추가
               이력이 없으면 → 온보딩 프롬프트 사용
               ↓
               LLM 호출
               ↓
               응답에 "검색 필요" 포함되면 → 검색 API 호출 후 재입력
               응답에 "검색 필요" 없으면 → 바로 출력
               ↓
               결과를 DB에 저장
            ```
      2. **AutoGPT(2023.3.30)** <span class="text-gray">/ Toran Bruce Richards / 개인 (게임 개발자)</span>
      3. **MCP(2024.11.25)** <span class="text-gray">/ Anthropic / 기업주도</span>