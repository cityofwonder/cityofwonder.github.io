---
layout: post
title: "[etc 00.] 마크다운 스타일 정리"
subtitle: "커스텀한 스타일링에 대한 활용법 기록"
categories: ["📂/etc"]
tags: ["blogging", "how_to", "markdown"]
banner:
  image: "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=1920"
  opacity: 0.8
  background: "rgba(0, 0, 0, 0.7)"
---

## **📍 개요**

markdown을 사이트에서 보여주는 형식인 github blog에서는 더 자유로운 스타일링이 가능하다. 나중에 쓸 때 참고해야하니.. 적어둔다

---

## **🖍️ 형광펜 효과**

<span class="highlight-yellow">노란색 형광펜</span>

<span class="highlight-green">초록색 형광펜</span>

<span class="highlight-blue">파란색 형광펜</span>

<span class="highlight-pink">분홍색 형광펜</span>

<span class="highlight-orange">주황색 형광펜</span>

<span class="highlight-purple">보라색 형광펜</span>

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

## **🎨 글자 색상 변경**

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
<span class="text-underline">밑줄 글씨</span>,
<span class="text-red text-bold">빨간색 굵은 글씨</span>,
<span class="highlight-yellow text-blue text-bold">노란 형광펜 + 파란 굵은 글씨</span>

**사용법:**
```html
<span class="text-bold">굵은 글씨</span>
<span class="text-italic">기울임 글씨</span>
<span class="text-underline">밑줄 글씨</span>
<span class="text-red text-bold">빨간색 굵은 글씨</span>
```

---

## 📦 박스

<div class="box-note">
💡 <strong>참고</strong><br>
양자 정보 학교 합격 기원
</div>

<div class="box-success">
✅ <strong>성공</strong><br>
학연생 합격 기원
</div>

<div class="box-warning">
⚠️ <strong>경고</strong><br>
이것저것 전부 다 잘되길 기원
</div>

<div class="box-danger">
🚨 <strong>위험</strong><br>
성공적인 기말 기원
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

긴 내용을 숨기고 필요할 때만 펼쳐볼 수 있음

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
<code>markdown="1"</code> 속성과 빈 줄이 필수. 없으면 마크다운 문법(코드블록, 리스트 등)이 작동하지 않게 됨
</div>

---

## 🎯 활용 예시

조합하면 이런 느낌..

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
