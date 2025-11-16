---
layout: post
title: "🎨 마크다운 스타일링 가이드"
subtitle: "형광펜, 색상, 박스, 접은글 활용법"
categories: ["📂/etc"]
tags: ["#blogging", "how_to", "markdown"]
banner:
  image: "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=1920"
  opacity: 0.8
  background: "rgba(0, 0, 0, 0.7)"
---

## 📍 소개

이 포스팅에서는 블로그에서 사용 가능한 다양한 스타일링 기능을 소개합니다. 마크다운의 기본 문법을 넘어 더 풍부한 표현이 가능합니다!

---

## 🖍️ 형광펜 효과

텍스트에 형광펜 효과를 적용할 수 있습니다. 6가지 색상을 지원합니다.

<span class="highlight-yellow">노란색 형광펜</span>으로 중요한 내용을 강조하거나,
<span class="highlight-green">초록색 형광펜</span>으로 성공 메시지를,
<span class="highlight-blue">파란색 형광펜</span>으로 정보를 표시할 수 있습니다.

추가로 <span class="highlight-pink">분홍색</span>,
<span class="highlight-orange">주황색</span>,
<span class="highlight-purple">보라색</span> 형광펜도 사용 가능합니다.

**사용법:**
```html
<span class="highlight-yellow">노란색 형광펜</span>
<span class="highlight-green">초록색 형광펜</span>
<span class="highlight-blue">파란색 형광펜</span>
<span class="highlight-pink">분홍색 형광펜</span>
<span class="highlight-orange">주황색 형광펜</span>
<span class="highlight-purple">보라색 형광펜</span>
```

---

## 🎨 글자 색상 변경

다양한 색상의 텍스트를 사용할 수 있습니다.

<span class="text-red">빨간색</span> /
<span class="text-blue">파란색</span> /
<span class="text-green">초록색</span> /
<span class="text-orange">주황색</span> /
<span class="text-purple">보라색</span> /
<span class="text-pink">분홍색</span> /
<span class="text-gray">회색</span>

**사용법:**
```html
<span class="text-red">빨간색 텍스트</span>
<span class="text-blue">파란색 텍스트</span>
<span class="text-green">초록색 텍스트</span>
```

### 텍스트 스타일 조합

<span class="text-bold">굵은 글씨</span>,
<span class="text-italic">기울임 글씨</span>,
<span class="text-underline">밑줄 글씨</span>도 사용 가능합니다.

조합도 가능합니다: <span class="text-red text-bold">빨간색 굵은 글씨</span>,
<span class="highlight-yellow text-blue text-bold">노란 형광펜 + 파란 굵은 글씨</span>

**사용법:**
```html
<span class="text-bold">굵은 글씨</span>
<span class="text-italic">기울임 글씨</span>
<span class="text-underline">밑줄 글씨</span>
<span class="text-red text-bold">빨간색 굵은 글씨</span>
```

---

## 📦 박스 스타일

중요한 정보를 박스로 강조할 수 있습니다.

<div class="box-note">
💡 <strong>참고</strong><br>
이것은 정보 박스입니다. 일반적인 팁이나 참고사항을 표시할 때 사용합니다.
</div>

<div class="box-success">
✅ <strong>성공</strong><br>
작업이 성공적으로 완료되었습니다! 긍정적인 결과를 표시할 때 사용합니다.
</div>

<div class="box-warning">
⚠️ <strong>경고</strong><br>
주의가 필요한 내용입니다. 사용자가 조심해야 할 사항을 알릴 때 사용합니다.
</div>

<div class="box-danger">
🚨 <strong>위험</strong><br>
매우 중요한 경고사항입니다. 심각한 문제가 발생할 수 있는 경우 사용합니다.
</div>

**사용법:**
```html
<div class="box-note">
💡 <strong>참고</strong><br>
정보 내용
</div>

<div class="box-success">
✅ <strong>성공</strong><br>
성공 메시지
</div>

<div class="box-warning">
⚠️ <strong>경고</strong><br>
경고 메시지
</div>

<div class="box-danger">
🚨 <strong>위험</strong><br>
위험 메시지
</div>
```

---

## 📂 접은글 (토글)

긴 내용을 숨기고 필요할 때만 펼쳐볼 수 있습니다.

<details>
<summary>더보기 (기본 예제)</summary>
<div class="toggle-content" markdown="1">

숨겨진 내용입니다. 클릭하면 펼쳐집니다.

여러 줄의 내용을 작성할 수 있습니다.

</div>
</details>

<details>
<summary>코드 예제 보기</summary>
<div class="toggle-content" markdown="1">

Python 코드 예제:

```python
def greet(name):
    """인사말을 출력하는 함수"""
    print(f"안녕하세요, {name}님!")

greet("개발자")
```

JavaScript 코드 예제:

```javascript
function greet(name) {
    console.log(`안녕하세요, ${name}님!`);
}

greet("개발자");
```

</div>
</details>

<details>
<summary>리스트와 함께 사용하기</summary>
<div class="toggle-content" markdown="1">

접은글 안에 리스트도 넣을 수 있습니다:

- 첫 번째 항목
- 두 번째 항목
  - 중첩된 항목 1
  - 중첩된 항목 2
- 세 번째 항목

번호 리스트도 가능합니다:

1. 준비하기
2. 실행하기
3. 완료하기

</div>
</details>

<details>
<summary>박스 스타일과 조합하기</summary>
<div class="toggle-content" markdown="1">

<div class="box-note">
💡 접은글 안에 박스 스타일도 넣을 수 있습니다!
</div>

<span class="highlight-yellow">형광펜 효과</span>나 <span class="text-red text-bold">색상 변경</span>도 모두 가능합니다.

</div>
</details>

**사용법:**
```html
<details>
<summary>제목</summary>
<div class="toggle-content" markdown="1">

숨겨진 내용

</div>
</details>
```

기본적으로 펼쳐진 상태로 시작하려면:
```html
<details open>
<summary>제목</summary>
<div class="toggle-content" markdown="1">

처음부터 펼쳐진 내용

</div>
</details>
```

<div class="box-warning">
⚠️ <strong>중요!</strong><br>
<code>markdown="1"</code> 속성과 빈 줄이 필수입니다. 이것이 없으면 마크다운 문법(코드블록, 리스트 등)이 작동하지 않습니다.
</div>

---

## 🎯 활용 예시

이제 모든 기능을 조합해서 사용해보겠습니다!

<details>
<summary>프로젝트 설치 가이드</summary>
<div class="toggle-content" markdown="1">

<div class="box-note">
💡 <strong>시작하기 전에</strong><br>
Node.js 14 이상이 설치되어 있어야 합니다.
</div>

### 설치 단계

1. <span class="highlight-yellow">저장소 클론</span>

```bash
git clone https://github.com/username/project.git
cd project
```

2. <span class="highlight-green">의존성 설치</span>

```bash
npm install
```

3. <span class="highlight-blue">개발 서버 실행</span>

```bash
npm run dev
```

<div class="box-warning">
⚠️ <strong>주의사항</strong><br>
포트 3000이 이미 사용 중이면 <span class="text-red text-bold">에러가 발생</span>할 수 있습니다.
</div>

<div class="box-success">
✅ <strong>완료!</strong><br>
이제 <code>http://localhost:3000</code>에서 확인할 수 있습니다.
</div>

</div>
</details>

<details>
<summary>문제 해결 (Troubleshooting)</summary>
<div class="toggle-content" markdown="1">

### 자주 발생하는 문제들

<details>
<summary>설치가 실패하는 경우</summary>
<div class="toggle-content" markdown="1">

<div class="box-danger">
🚨 <code>npm install</code> 실패 시:
</div>

- 캐시 삭제: `npm cache clean --force`
- node_modules 삭제 후 재설치
- <span class="text-orange">npm 버전 확인</span>: `npm --version`

</div>
</details>

<details>
<summary>포트 충돌이 발생하는 경우</summary>
<div class="toggle-content" markdown="1">

다른 포트를 사용하려면:

```bash
PORT=3001 npm run dev
```

또는 `.env` 파일에 추가:

```
PORT=3001
```

</div>
</details>

</div>
</details>

---

## 🌙 다크모드 지원

모든 스타일이 <span class="highlight-purple">다크모드를 자동으로 지원</span>합니다!

라이트/다크 테마를 전환해도 가독성이 유지됩니다.

<div class="box-note">
💡 <strong>Tip</strong><br>
우측 상단의 테마 전환 버튼으로 다크모드를 테스트해보세요!
</div>

---

## 📚 정리

이제 다양한 스타일링 기능을 활용해서 더 읽기 쉽고 아름다운 포스팅을 작성할 수 있습니다.

**주요 기능 요약:**
- 🖍️ **6가지 형광펜 색상** (yellow, green, blue, pink, orange, purple)
- 🎨 **7가지 텍스트 색상** (red, blue, green, orange, purple, pink, gray)
- 📦 **4가지 박스 스타일** (note, success, warning, danger)
- 📂 **접은글 토글** (details/summary)
- ✨ **스타일 조합 가능**
- 🌙 **다크모드 자동 지원**

<div class="box-success">
✅ 마크다운을 더욱 풍부하게 표현해보세요!
</div>

---

**작성일**: 2025년 11월 16일
