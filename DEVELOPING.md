# 로컬 개발

이 블로그를 다른 컴퓨터에서 띄우고 글을 쓰는 방법.
테마 자체(Yat) 설명은 [README.md](README.md) 에 있다.

## 필요한 것

| | 최소 버전 | 비고 |
| --- | --- | --- |
| Ruby | 3.0+ | 현재 3.2 / 3.4 에서 동작 확인 |
| Bundler | 2.x | `gem install bundler` |
| Node | — | 불필요. 태그 그래프의 d3 는 CDN 에서 로드 |

`Gemfile.lock` 은 `.gitignore` 에 있다. 플랫폼마다 다르게 풀리기 때문에 각자
받은 자리에서 `bundle install` 로 새로 만든다.

### Ruby 설치

```bash
# Ubuntu / Debian / WSL
sudo apt update && sudo apt install -y ruby-full build-essential zlib1g-dev
gem install --user-install bundler
export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"   # 셸 프로필에 추가

# macOS
brew install ruby && gem install bundler
export PATH="$(brew --prefix ruby)/bin:$PATH"            # 셸 프로필에 추가
```

Windows 는 [RubyInstaller](https://rubyinstaller.org) 의 **Ruby+Devkit** 를 받는다
(`ridk install` 에서 MSYS2 툴체인까지 설치). WSL 에 따로 깔 필요는 없다.

## 서버 띄우기

```bash
./serve.sh                  # http://127.0.0.1:4000
./serve.sh --port 4001      # 추가 인자는 그대로 jekyll serve 로 전달
./serve.sh --host 0.0.0.0   # 같은 네트워크의 다른 기기에서 접속
```

처음 실행이거나 gem 이 모자라면 `bundle install` 을 알아서 돌린다.

```powershell
# Windows PowerShell
.\serve.ps1          # 윈도우 Ruby 우선, 없으면 WSL 로 폴백
.\serve.ps1 -Wsl     # WSL 강제
```

`livereload` 와 `force_polling` 은 `_config.yml` 에 있어서 저장하면 브라우저가
알아서 새로고침된다. `force_polling` 은 WSL 에서 `/mnt/c` 의 inotify 가 동작하지
않아 켜 둔 것이고, 다른 환경에서도 해롭지는 않다.

### 자주 막히는 곳

| 증상 | 원인 / 해결 |
| --- | --- |
| `Could not find <gem> in locally installed gems` | 다른 플랫폼에서 만든 `Gemfile.lock`. `bundle install` 로 다시 푼다 |
| `serve.ps1` 이 WSL 로 가서 실패 | WSL 안에 Jekyll 이 없고 `bundle` 이 `/mnt/c/...` 의 윈도우 실행파일로 잡힌 것. 윈도우 Ruby 를 쓰거나 WSL 에 직접 설치 |
| 4000 포트 사용 중 | `./serve.sh --port 4001` |
| 저장해도 새로고침이 안 됨 | 네트워크 드라이브/공유 폴더면 폴링 주기를 늘려야 할 수 있다 |

## 사진 넣기 — `watch-images.ps1` (Windows)

오늘 날짜 폴더(`assets/images/<yyyy-MM-dd>/`)를 감시하다가, 파일을 떨구면
캡션을 묻고 완성된 `<figure>` 블록을 **클립보드에 복사**해 준다. 글에 그대로
붙여넣으면 된다.

```powershell
cd <레포 루트>
.\watch-images.ps1
```

```
Watching: ...\assets\images\2026-10-05
Copy a file to trigger. Press Enter for filename as caption. Ctrl+C to exit.

New file: screenshot.png
Enter caption (or press Enter to skip): 실행 결과      # 비우면 파일명이 캡션
Is it a pair? (y/N): n
```

나오는 결과:

```html
<figure style="text-align: center;">
    <img src="/assets/images/2026-10-05/screenshot.png" alt="실행 결과">
    <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;">실행 결과</figcaption>
</figure>
```

`Is it a pair?` 에 `y` 를 넣으면 **두 번째 이미지를 기다렸다가** 가로로 나란히
붙는 `.img-pair` 블록을 만든다.

- 반드시 **레포 루트에서** 실행한다. 감시 경로를 현재 위치 기준으로 잡는다.
- 폴더는 **오늘 날짜**로 고정이다. 과거 날짜 글에 넣으려면 만들어진 경로만
  손으로 고치면 된다.
- PowerShell 전용이다. 다른 OS 에서는 `<figure>` 를 직접 쓰거나, Notion 에서
  작성한 뒤 [notion-to-github-blog-MD](https://github.com/cityofwonder/notion-to-github-blog-MD)
  변환기를 쓰면 캡션까지 그대로 옮겨진다.

## Notion 에서 글 옮기기

옆 레포 `notion-to-github-blog-MD` 가 Notion 데이터베이스를 `_posts` 로
동기화한다. 디렉터리 구조는 다음을 가정한다.

```
study/git/
  cityofwonder.github.io/        # 이 레포
  notion-to-github-blog-MD/      # 변환기
```

```bash
cd ../notion-to-github-blog-MD
python sync_notion_db.py "<DB URL>"          # 계획만
python sync_notion_db.py "<DB URL>" --yes    # 반영
```

자세한 내용은 그 레포의 README 를 본다.

## 글 앞머리(front matter)

```yaml
---
layout: post
title: "제목"
subtitle: "부제"
categories: ["📂/paper-review/"]
tags: ["tag"]
top: 1                 # 목록 상단 고정. 숫자가 작을수록 앞
status: "진행 중"       # 진행 중 → 작성중 뱃지, 작성완료 → 작성완료 뱃지
draft: true            # status 없이 작성중 뱃지만 달 때
notion: true           # 변환기가 만든 글 (수동 편집은 다음 싱크에 덮어쓰임)
notion_id: "..."       # 싱크 식별자. 지우면 중복 생성된다
banner:
  image: "/assets/images/<date>/<file>"   # 글 머리 카드 배경 + 링크 미리보기 그림 (opacity/background 는 안 쓰임)
---
```

`_posts/draft_*.md` 는 Jekyll 이 날짜 형식으로 인식하지 못해 **발행되지 않는다.**
초안을 레포에 두되 공개하지 않을 때 쓴다.

### Directory (보드) 글

Notion 에서 `layout` 을 `directory` 로 둔 페이지는 `layout: directory` 글이 된다.
여러 글을 heading 별 열(column)로 묶어 보여주는 보드 페이지다.

```yaml
---
layout: directory
title: "..."
date: 2026-11-18 07:15:00 +0000   # 마지막 수정 시각 → 수정할 때마다 피드 맨 위
permalink: /directory/<slug>/     # date 가 바뀌어도 URL 고정
cover: "/assets/images/..."       # 선택. 피드 카드/헤더 배경
directory:
  - title: "A. ..."               # 열
    items:
      - id: "<notion id>"         # 이 notion_id 를 가진 글로 연결
        title: "..."              # 그 글이 아직 없을 때만 표시 ("준비 중")
---
```

- 피드 카드: `_includes/views/directory-card.html` (이미지 자리에 미니 보드)
- 보드 페이지: `_layouts/directory.html`, 카드: `_includes/views/board-card.html`
- 스타일: `_sass/misc/directory.scss`

## 빌드 확인

```bash
bundle exec jekyll build        # _site/ 에 생성 (gitignore 됨)
```

푸시하면 `.github/workflows/jekyll.yml` 이 같은 빌드를 돌려 GitHub Pages 로
배포한다.
