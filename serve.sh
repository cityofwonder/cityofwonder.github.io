#!/usr/bin/env bash
# Jekyll dev server with livereload. Linux, macOS, WSL, Git Bash.
#
#   ./serve.sh                 # http://127.0.0.1:4000
#   ./serve.sh --port 4001     # anything extra is passed to `jekyll serve`
#   ./serve.sh --host 0.0.0.0  # reachable from another device on the LAN
#
# livereload and force_polling are set in _config.yml, so no extra flags are
# needed for the page to refresh on save. On Windows PowerShell use serve.ps1,
# which prefers the Windows Ruby and falls back to WSL.

set -euo pipefail

cd "$(dirname "$0")"

if ! command -v bundle >/dev/null 2>&1; then
  cat >&2 <<'MSG'
bundler 를 찾을 수 없습니다. Ruby(>= 3.0) 와 bundler 가 필요합니다.

  Ubuntu/Debian/WSL : sudo apt update && sudo apt install -y ruby-full build-essential zlib1g-dev
                      gem install --user-install bundler
  macOS (Homebrew)  : brew install ruby && gem install bundler
                      # Homebrew 의 ruby 를 PATH 앞에 두어야 합니다
  Windows           : https://rubyinstaller.org  (Ruby+Devkit),
                      또는 PowerShell 에서 .\serve.ps1 사용

PATH 에 gem 의 사용자 설치 경로가 없으면 아래를 셸 프로필에 추가하세요:
  export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
MSG
  exit 1
fi

# `bundle check` fails when a gem in Gemfile.lock is not installed here -- a
# fresh clone, or a lockfile resolved on another platform.
if ! bundle check >/dev/null 2>&1; then
  echo "의존성을 설치합니다 (bundle install)..." >&2
  bundle install
fi

echo "Serving on http://127.0.0.1:4000  (Ctrl+C to stop)"
exec bundle exec jekyll serve --livereload "$@"
