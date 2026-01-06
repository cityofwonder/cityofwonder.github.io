---
layout: post
title: "[pwn-wargame 02.] 내부CTF2025-🎅Forty-seven-bells🎄 문제풀이"
subtitle: ""
categories: ["📂/wargame/pwn-wargame", "📂/CTF/etc"]
tags: ["pwn", "wargame", ]
banner:
  image: "/assets/images/2025-12-10/xmas_hangyodon.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---
<details>
<summary>🔸[내부CTF2025-pwn]Forty-Seven-Bells</summary>

<div class="toggle-content" markdown="1">
<div class="box-note">

💡 문제 출처
<div style="border: 1px solid #ddd; border-radius: 8px; padding: 15px; margin: 10px 0;">
  <a href="https://github.com/amethyst0225" target="_blank">
    <strong>amethyst0225's github</strong><br>
    <span style="color: gray; font-size: 0.9em;">https://github.com/amethyst0225</span>
  </a>
</div>

</div>
<details>
<summary>문제 구조</summary>
<div class="toggle-content" markdown="1">

```bash
C:.
│  Dockerfile
│  flag
│  get-docker.sh
│  libprob.so
│  prob
│  
├─for_user
└─__MACOSX
    │  ._for_user
    │  
    └─for_user
            ._Dockerfile
            ._flag
            ._libprob.so
            ._prob
```

</div>
</details>

</div>
</details>

<div class="box-warning">
💡 <strong>전체 로드맵</strong><br>
<figure style="text-align: center;">
    <img src="/assets/images/2025-12-10/KakaoTalk_20251210_022210403.jpg" alt="CykorCTF2025-asterisk 풀이 전체 로드맵">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">CykorCTF2025-asterisk 풀이 전체 로드맵</figcaption>
</figure>
</div>
---
## 1. <span class="highlight-blue"> Premitive - Static Analysis</span>
~~시험공부하다가 너무 졸려서 적는 롸업..~~<br>
~~탈모탈모빔,, 교수님께서 답장이 오질않는다~~

1. ,,,
    <figure style="text-align: center;">
      <img src="/assets/images/2025-12-12/20251212_034549.png" alt="전체 함수 목록 확인: main, _start, _init, _fini 표준 진입점">
      <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">전체 함수 목록 확인: main, _start, _init, _fini 표준 진입점</figcaption>
    </figure>

    <figure style="text-align: center;">
      <img src="/assets/images/2025-12-12/20251212_034926.png" alt="main 함수 확인: dlopen, dlsym, dlerror 동적 라이브러리 로">
      <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">main 함수 확인: dlopen, dlsym, dlerror 동적 라이브러리 로딩</figcaption>
    </figure>
  
     - <code>fopen</code>, <code>fread</code>, <code>fclose</code> → 파일 I/O<br>
     - <code>mmap</code>, <code>srand</code>, <code>rand</code> -> 메모리/랜덤
     위 사항들을 간주어봤을 때, 외부 .so 파일을 런타임에 로드함. 즉, <span class="highlight-yellow">prob은 로더일 뿐 실제 로직은 libprob.so<span class="text-red text-bold">(에서 로드해오는 challenge_main)</span>에 있음</span>

    <details>
    <summary>main 세부 사항</summary>
      <div class="toggle-content" markdown="1">
      ```c
        // 1. 랜덤 시드 설정 (urandom 또는 time)
        fopen("/dev/urandom", "r");
        srand(seed);
        // 2. 랜덤 패딩 mmap (자체 PIE 구현)
        local_24 = (rand() & 0xff) << 0xc;  // 0 ~ 255 페이지
        mmap(NULL, local_24, ...);

        // 3. libprob.so 로드
        dlopen("./libprob.so", RTLD_NOW);

        // 4. challenge_main 함수 찾아서 호출
        pcVar4 = dlsym(handle, "challenge_main");
        (*pcVar4)();  // challenge_main() 호출
      ```
      </div>
    </details>

    
2. libprob.so의 challenge_main 분석
    <figure style="text-align: center;">
      <img src="/assets/images/2025-12-12/20251212_035844.png" alt="libprob.so의 함수 목록 확인">
      <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">libprob.so의 함수 목록 확인</figcaption>
    </figure>
    <figure style="text-align: center;">
      <img src="/assets/images/2025-12-12/20251212_125905.png" alt="readelf 명령어">
      <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">readelf 명령어</figcaption>
    </figure>

    ```bash
      //libpro.so에서 custom된 함수들의 오프셋은 다음과 같음.
      present @ 0x74c
      santa @ 0x7f5  
      rudolph @ 0x825
      elves @ 0x899
      challenge_main @ 0x8e1
      prologue @ 0x799
    ```
    ```c
      void challenge_main(void)

      {
        undefined4 local_14 [2];
        
        setvbuf(stdin,(char *)0x0,2,0);
        setvbuf(stdout,(char *)0x0,2,0);
        do {
          prologue();
          __isoc99_scanf(&DAT_00010ae8,local_14);
          getchar();
          switch(local_14[0]) {
          case 1:
            santa();
            break;
          case 2:
            rudolph();
            break;
          case 3:
            elves();
            break;
          case 4:
            puts("Bye!");
                          /* WARNING: Subroutine does not return */
            exit(0);
          default:
            puts("Invalid choice!");
          }
        } while( true );
      }

    ```
    challenge_main은 단순히 메뉴를 제공하는 함수

3. challenge_main의 각 메뉴가 되는 함수 분석
   ```c
    //1일때 호출되는 santa()
    void santa(void)

    {
      undefined1 auStack_c [4];
      
      printf("Index: ");
      __isoc99_scanf(&DAT_00010ac0,auStack_c);
      return;
    }
    //2일 때 호출되는 roudolgh()
    void rudolph(void)

    {
      undefined4 local_18;
      int local_14 [2];
      
      printf("Index: ");
      __isoc99_scanf(&DAT_00010ac0,local_14);
      printf("Value: ");
      __isoc99_scanf(&DAT_00010acc,&local_18);
      *(undefined4 *)(&bss_buffer + local_14[0]) = local_18;
      puts("Written!");
      return;
    }

    //3일 때 호출되는 elves()
    void elves(void)

    {
      char acStack_108 [255];
      undefined1 local_9;
      
      printf("Message: ");
      read(0,acStack_108,0xff);
      local_9 = 0;
      printf(acStack_108);
      putchar(10);
      return;
    }

    //4일 때는 puts(Bye!)
   ```