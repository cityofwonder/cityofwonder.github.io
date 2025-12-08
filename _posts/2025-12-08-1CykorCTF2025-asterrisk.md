---
layout: post
title: "[web-wargame 01.] CykorCTF2025-asterisk 문제풀이"
subtitle: ""
categories: ["📂/wargame/web-wargame", "📂/CTF/CykorCTF2025"]
tags: ["web", "wargame", "globbing attack", "input validaion bypass"]
banner:
  image: "https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=1920"
  opacity: 0.8
  background: "rgba(0, 0, 0, 0.7)"
---

<details>
<summary>🔸[Cykor2025-web-1]Asterisk</summary>

<div class="toggle-content" markdown="1">
<div class="box-note">

💡 Just print * ! The flag format is CyKor{ }.<br>
<br>
Please verify your exploit locally first before asking for an instance. 🙏 You can use the pow-solver.py file to obtain a container instance.<br>
<br>
http://54.180.15.185:8080/<br>

</div>
<details>
<summary>문제 구조</summary>
<div class="toggle-content" markdown="1">

```bash
C:.
│  Dockerfile
│  pow-solver.py
│
└─server
    │  core.js
    │  index.js
    │  package-lock.json
    │  package.json
    │
    ├─bin
    │      mini-run.js
    │
    ├─public
    │      app.html
    │      index.html
    │      login.html
    │      signup.html
    │
    └─users
            users.json
```

</div>
</details>

</div>
</details>

## 1. 👀 static analysis

첫 시작은 index.js를 분석하는 것이다.
<details>
<summary>why?</summary>
<div class="toggle-content" markdown="1">

1. **.html 과 .json은 제끼는 이유**<br>
    -> html은 사용자의 브라우저에서 실행되는 코드로, 아무리 조작해도 서버에 영향이 없음. XSS공격에선 유의미할 수 있으나, 해당 문제에선 서버 장악(RCE) 가 필요하기 때문에 ❌.<br>
    -> json은 데이터/설정이므로, 실행능력이 없음. 공격의 결과물로 바뀔 수는 있어도 공격의 시작점이 될 순 없다! ❌.


2. **.js 중에서도 index.js를 보는 이유 (entry point / 종속성 관점)**<br>
   1. <span class =  "text-bold text-orange">entry point</span>
        ```json
            {
            "name": "asterisk",
            "version": "2.0.0",
            "private": true,
            "type": "commonjs",
            "main": "index.js",
            "scripts": {
                "start": "node index.js"
            },
            "dependencies": {
                "express": "^5.1.0",
                "express-session": "^1.18.2"
            }
            }
        ```
        "start": "node index.js"에서 서버를 켜면 index.js가 가장 먼저 실행되는 것을 알 수 있다.

    2. <span class =  "text-bold text-orange">종속성</span> <br>
        한편, <span class="text-red text-bold">index.js는 쉘 명령어를 통해 mini-run.js를, mini-run.js는 core.js를 호출</span>하고 있다.
        ![index.js](https://github.com/user-attachments/assets/d0e9d4a7-98ce-4813-bc66-6379507d452c)
        ![mini-run.js](https://github.com/user-attachments/assets/5a60b247-eeed-4a27-adfa-d7583b3ed965)

</div>
</details>

index.js 안에서의 <span class =  "text-bold text-orange">데이터 흐름의 분석 과정</span>은 다음과 같다.
1. <span class="highlight-yellow">**Backwards tracing: 시스템을 장악할 수 있는 함수 (sink) 위주로 검색하기**</span><br>
   검색 키워드: <code>spawn</code>, <code>exec</code>, <code>eval</code>, <code>system</code>, <code>query</code>
   ![index.js - shell 실행 spawn 함수](ttps://github.com/user-attachments/assets/11c056df-8d46-4094-bb60-e56ee904da0d)
   이 가운데에서도 spawn 함수만 indexing 된다. sh를 실행하는데, 그 변수가 되는 shell은 input으로부터 오는 것을 알 수 있다.
            
2. <span class="highlight-yellow">**shell을 만들 때 쓰이는 input을 거꾸로 따라가기**</span><br>
    ![input은 runWithEchoPipeline의 arg1](https://github.com/user-attachments/assets/50de46e4-02ed-44c2-94df-bc52c0c9dc83)
    ![runWithEchoPipeline의 호출 지점](https://github.com/user-attachments/assets/e961b295-5944-4685-8e89-d317611df61f)
    shell을 만드는 input은 정의를 따라가보면 runWithEchoPipeline의 arg1이고, runWithEchoPipeline의 모든 참조를 따라가보면 위 사진과 같이 두 지점에서 호출하고 있는 것을 확인할 수 있다. 순서대로 다음과 같다.
    <div class="box-note" markdown="1">

    **💡Enpoint?**

    - app.get('/주소', ...): GET 요청을 받는 입구
    - app.post('/주소', ...): POST 요청을 받는 입구<br>
    
    소스 코드에서 app.post('/submit'이라는 글자를 보자마자 브라우저나 파이썬으로 http://서버주소/submit에 POST 요청을 보내면 이 함수가 실행될 것을 알 수 있음.
    </div>
    
    ```javascript
    // submit handler
    app.post('/submit', ... async (req, res) => {
        // [Source] 사용자가 보낸 데이터에서 'input'을 꺼냄
        const { code, input } = req.body || {}; 
        
        // [Sink] 사용자가 보낸 'input'을 그대로 함수에 넣음 -> 공격 가능!
        const r = await runWithEchoPipeline({ code, input }); 
        // ...
        });
    ```
    ```javascript
    app.post('/judge-all', ... async (req, res) => {
        const { code } = req.body || {}; // 여기서는 'code'만 꺼내고 'input'은 안 꺼냄
        // [Sanitization] 서버가 스스로 'input' 값을 1부터 99까지 강제로 만듦
        const inputs = Array.from({ length: 99 }, (_, i) => String(i + 1));
        for (const t of inputs) {
            // [Safe] 사용자가 뭘 보내든 상관없이, 여기 들어가는 t는 무조건 "1", "2"... 
            const r = await runWithEchoPipeline({ code, input: t });
            // ...
        }
    });
    ```
    따라서 아래와 같은 경우 submit handler가 취약할 수 있음을 이해할 수 있다.
    ![submit handler vs judge-all handler](https://github.com/user-attachments/assets/61fa5974-85f1-4494-96b3-893287b5dc47)
    
3. <span class="highlight-yellow">**submit handler에서 통과하는 shell이 하는 동작 관찰하기**</span><br>
    <code>const shell = `echo ${input} | node ../bin/mini-run.js --b64code '${b64code}'`;</code>에 '\n*'를 넘기게 되면,

    ```bash
        echo
        * | node ...
    ```

    가 동작하게 된다. 쉘에서 줄바꿈은 "앞의 명령어를 끝내고, 다음 명령어를 시작해라"라는 뜻으로 세미콜론과 같은 역할을 하므로, 와일드카드(*)가 동작하는 두번째 명령어가 중요하다.
    ![리눅스 쉘에서 와일드 카드의 동작](https://github.com/user-attachments/assets/35980045-6da9-4c9d-82b6-d71d29c85959)
    예를 들어 echo * 결과가 아래와 같다면 순서대로 <code>{실행할 프로그램(명령어)} {args0 args1 ...}</code> 로 인식하게 된다.

    ```bash
        > echo *
        >> python3 hello.py hi
        > * //python3 hello.py hi
        >> hi
    ```

    같은 원리로 <code>bash cscript</code>와 같은 명령어도 실행할 수 있다. 다시금 쉘 프로그램을 실행하여 미리 만들어둔 바이너리를 실행할 수 있는 것이다(cat ./flag.txt)<br>
    <span class="text-red text-bold text-italic">⇨ 입력 검증값 우회, shell injection ⇨ RCE🚨</span>

4. <span class="highlight-yellow">**shell을 만들 때 쓰이는 input을 거꾸로 따라가기; runWithEchoPipeline 함수의 validateTestInput**</span><br>
   
    한편, 이렇게 runWithEchoPipeline에서 초기화된 input 변수가 shell injection에 중요한 역할을 한다는 것을 알게된 시점에서, input 값에 대한 filtering 조건이 없는지 확인해봐야한다.
    
    <div class="box-danger" markdown = "1">
    **submit 발생 > runWithEchoPipeline > <span class = "text-bold text-red">!!</span> > shell 실행** <br>
    으로 이어지는데, 
    ![runWithEchoPipeline의 흐름](https://github.com/user-attachments/assets/cc50d61e-8bdd-4827-8cc6-ae5caa475659)
    이 때 validateTestInput이 filter 역할을 한다.
    </div>

    ![validateTestInput의 정의](https://github.com/user-attachments/assets/228930e2-e255-4d85-8470-24e5c4cda9a5)
    
    ```javascript
    function validateTestInput(inp) {
        // 1. 타입 검사: 입력값이 문자열이 아니면 차단
        if (typeof inp !== 'string') return false;

        // 2. 길이 검사: 글자 수는 1글자 또는 2글자여야 함
        // 이 제약 때문에 긴 공격 코드는 넣을 수 없지만, '\n*' 같은 2글자 공격은 가능
        if (inp.length < 1 || inp.length > 2) return false;

        // 3. 비교 기준값 1 설정 (숫자)
        // [!] check 변수에 문자열 "0"이 아니라, 숫자(Number) 0을 할당했습니다.
        const check = 0;

        // 4. 비교 기준값 2 설정 (문자열)
        // 복잡해 보이지만, 결과적으로 upper는 문자열 "9"가 됨
        // check(0) -> "0" -> ASCII(48) -> +9(57) -> ASCII 57은 "9"
        const upper = String.fromCharCode(check.toString().charCodeAt(0) + 9);

        // 5. 반복문: 입력된 문자열을 한 글자씩 검사
        for (const ch of inp) {
            // 6. 핵심 취약점 발생 지점
            // 논리: (ch >= 0) 또는 (ch <= "9") 중 하나라도 참이면 통과
            if (!(ch >= check || ch <= upper)) return false;
        }
        return true;
    }
    ```
    자바스크립트에서 문자열과 숫자를 비교할 때, 자바스크립트 엔진은 문자열을 **숫자로 강제 변환(Type Coercion)**하여 비교한다. 일반적인 문자 'a', 'z' 등은 Number('a')가 NaN이 되어 NaN >= 0은 false가 되지만, **공백 문자( )**나 **개행 문자(\n, \t)**는 숫자로 변환하면 **0**이 되므로, 줄바꿈 등 Shell injection에 치명적인 문자들을 허용해주게 된다.

    한편 두 condition 중 어느것 하나만 만족하면 되기 때문에, 후자도 관찰해보면 바로 ASCII 코드 상에서 "9"보다 작으면(ASCII 코드값 0x57) 통과된 다는 것이다. 이 두개의 느슨한 명제 때문에 아래가 가능하다
    아스키 57보다 작은 문자들: ! (33), " (34), # (35), $, %, &, ', (, ), * (42), +, ,, -, ., /.

그렇다면 이제 '1-2. shell을 만들 때 쓰이는 input을 거꾸로 따라가기'에서 확인한 submit handler가 input으로 뭘 가져오는 것인지 확인해보자.
![server/public/*.html에서 submit handler 참조 확인하기](https://github.com/user-attachments/assets/056464b7-c4b4-4fca-8c23-89ae62dc8723)
![app.html에서 submit handler 호출 확인하기](https://github.com/user-attachments/assets/2a123722-23fc-455c-8132-b9409ab976b4)
정확히 어떤 POST 요청에 대해 어떤 값이 날라가는지는 docker setting 후 개발자 도구에서 관찰할 수 있다.

## 2. Setting docker for Debugging

<span class="text-italic text-gray">~~나는 디버깅 안되면 절대 익스를 못 작성하는데, 딱히 그러지 않고도 잘 솔브 하는 사람을 보면 신기하다..~~</span>

주어진 도커파일을 참고하면, EXPOSE 3000 포트를 사용하므로 Dockerfile이 있는 디렉터리에서 아래를 실행하면 된다.

```bash
    docker build -t asterisk .
    docker run -d -p 3000:3000 --name asterisk_chall asterisk
    docker exec -it asterisk_chall /bin/bash
```

![docker setting 완료 후](https://github.com/user-attachments/assets/8ec9606a-562d-4353-9677-c79f7ad19459)

run까지만 해도 http://localhost:3000 접속은 가능하다. 익스 과정에서 서버 내부 상황을 보고싶다면 exec까지 실행해주면 된다.

## 3. Dynamic Analysis with Docker

메인 페이지에서 보이는 몇개 버튼을 눌러보면 http://localhost:3000/nnn.html 와 같은 방식으로 접속되는 것을 확인할 수 있다.

<details>
<div class="toggle-content" markdown="1">

- 별도의 경로를 주지 않아도 index.html이 보이는 이유는?
  - 웹서버의 convention으로, 웹 서버(Node.js/Express, Apache, Nginx 등)는 주소 뒤에 특정 파일명을 적지 않고 **루트(Root, /)**만 요청하면, 자동으로 **"기본 파일"**을 찾아서 보여주도록 설계되어있으며, 그 기본파일의 이름이 **index.html**이 되는 것

```javascript
    app.use(express.static(path.join(__dirname, 'public')));
```
- 대부분의 서버는 위와 같이 사용자가 디렉터리만 요청하고 파일명을 안 적었을 경우, 그 폴더 안의 index.html이 있는지를 찾아보고 -> 있으면 사용자에게 그걸 보여주도록 하는 코드를 포함하고 있음.(index.js의 23번 line)

</div>
</details>

관찰을 토대로, submit endpoint에 접근하기 위해 '1. static analysis'의 마지막 부분에서 확인한 app.html을 경로로 넘겨줘보면, 바로 **.../login.html로 리다이렉트** 된다. 이로부터 다음 세가지를 알 수 있다.

1. 일단 app.html이 서버에 있긴 함(없으면 404 반환)
2. app.html은 로그인을 거쳐야 접근할 수 있는 페이지임
3. submit endpoint에 접근하기 위해 index.html > login.html >..> app.html을 거쳐야함

!['app.html' 호출 문자열 index](https://github.com/user-attachments/assets/89c4f214-5f97-44ea-98c2-56629bb9f954)
![login.html에서 'app.html'을 호출하는 지점](https://github.com/user-attachments/assets/6a4f2742-886a-4afe-8cc6-bf9739e25973)

위 두 사진을 참고하면, login.html에서 로그인 성공시 app.html로 이동하게 된다.
그렇담 확인한 취약점은 app.html에 있기 때문에 아무 계정으로 로그인하고 app.html 페이지로 넘어간다.(계정정보는 server의 /app/server/users에 기록)

![app.html에서 submit handler 호출 확인하기](https://github.com/user-attachments/assets/2a123722-23fc-455c-8132-b9409ab976b4)

submit handler는 $('#submit')이 눌릴 때 트리거된다.
따라서 아래와 같이 식별할 수 있다.
![브라우저 console 탭에서 버튼 식별하기](https://github.com/user-attachments/assets/e16b5bf0-2497-41be-b3e9-58960bccdd4b)

그렇담 이제 해당 버튼을 눌렀을 때 어떤 액션이 일어나는지 디버깅 해볼 차례다.
![브라우저 sources 탭에서 관찰 코드 식별하여 bp 걸고 실행하기](https://github.com/user-attachments/assets/2b736b28-7b75-402f-8413-a699f7c49b7e)

적당한 값과 함께 $('#submit')버튼을 누르면 bp에 걸리고, 원하는 변수에 마우스온 함으로써 페이지 기준 아래쪽 칸의 값(5678) input 변수로 들어간다는 것을 알 수 있으며, 이는 마저 실행하면서 실제 이벤트가 발생됨에 따라 Network 탭에서도 아래 두번째 사진처럼 확인 가능하다.
![bp 걸린 후 값 확인하기](ttps://github.com/user-attachments/assets/c978d38b-e270-4bbc-a302-de2aa1e771a9)
![브라우저 Network 탭에서 값 관찰](https://github.com/user-attachments/assets/6a39059d-89c4-4a2c-a5e8-033baea0fd46)

## 4. exploit 작성