---
layout: post
title: "[pwn-wargame] dh-excercise-v8"
subtitle: ""
categories: ["📂/"]
tags: ["V8"]
notion: true
notion_id: "3fbbb540-e5fe-805b-ad2b-c28b6eae55aa"
notion_synced: "2026-11-23T17:05:00.000Z"
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

```python
$root = "C:\Users\jshrb\Desktop\wargame-pwn\dh-exercise-v8"
Write-Output "=== TOP LEVEL ==="
Get-ChildItem $root -Force | Select-Object Name, Mode, Length | Format-Table -AutoSize
Write-Output "=== deploy/ (depth 2) ==="
Get-ChildItem "$root\deploy" -Force -ErrorAction SilentlyContinue | Select-Object Name, Mode, Length | Format-Table -AutoSize
Write-Output "=== deploy/patches ==="
Get-ChildItem "$root\deploy\patches" -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{N='Rel';E={$_.FullName.Replace("$root\",'')}}, Length | Format-Table -AutoSize
Write-Output "=== deploy/examples ==="
Get-ChildItem "$root\deploy\examples" -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{N='Rel';E={$_.FullName.Replace("$root\",'')}}, Length | Format-Table -AutoSize
Write-Output "=== deploy/runner ==="
Get-ChildItem "$root\deploy\runner" -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{N='Rel';E={$_.FullName.Replace("$root\",'')}}, Length | Format-Table -AutoSize
Write-Output "=== flag_control ==="
Get-ChildItem "$root\flag_control" -Recurse -Force -ErrorAction SilentlyContinue | Select-Object @{N='Rel';E={$_.FullName.Replace("$root\",'')}}, Length | Format-Table -AutoSize
```

<details>
<summary markdown="span">결과</summary>
<div class="toggle-content" markdown="1">

```python
=== TOP LEVEL ===

Name         Mode   Length
----         ----   ------
debug        d-----       
deploy       d-----       
flag_control d-----       
Dockerfile   -a---- 781   
flag         -a---- 8     


=== deploy/ (depth 2) ===

Name     Mode   Length
----     ----   ------
examples d-----       
out      d-----       
patches  d-----       
runner   d-----       


=== deploy/patches ===

Rel                      Length
---                      ------
deploy\patches\README.md    337
deploy\patches\v8.patch   18475


=== deploy/examples ===

Rel                        Length
---                        ------
deploy\examples\example.js     26


=== deploy/runner ===

Rel                     Length
---                     ------
deploy\runner\run.sh        30
deploy\runner\runner.py    526


=== flag_control ===

Rel                      Length
---                      ------
flag_control\flag_reader     68
```

</div>
</details>

```python
$root = "C:\Users\jshrb\Desktop\wargame-pwn\dh-exercise-v8"
Write-Output "=== deploy/runner/run.sh ==="
Get-Content "$root\deploy\runner\run.sh"
Write-Output "`n=== deploy/runner/runner.py ==="
Get-Content "$root\deploy\runner\runner.py"
Write-Output "`n=== deploy/patches/README.md ==="
Get-Content "$root\deploy\patches\README.md"
Write-Output "`n=== deploy/examples/example.js ==="
Get-Content "$root\deploy\examples\example.js"
Write-Output "`n=== deploy/out/args.gn ==="
Get-Content "$root\deploy\out\args.gn"
Write-Output "`n=== flag_control/flag_reader (file type) ==="
$fr = "$root\flag_control\flag_reader"
$bytes = [System.IO.File]::ReadAllBytes($fr)
Write-Output ("first bytes: " + (($bytes[0..15] | ForEach-Object { $_.ToString('x2') }) -join ' '))
Write-Output ("length: " + $bytes.Length)
```

<details>
<summary markdown="span">결과</summary>
<div class="toggle-content" markdown="1">

```python
=== deploy/runner/run.sh ===
#! /bin/bash
python3 runner.py

=== deploy/runner/runner.py ===
import sys
import uuid
import subprocess

filename = f"/tmp/{str(uuid.uuid4())}"

print("Please send your own payload! (receive until '<EOF>'), Max: 2000bytes", flush=True)

byt = 0
with open(filename, "w") as f:
    while byt < 2000:
        line = sys.stdin.readline()

        if "<EOF>" in line:
            break

        if len(line) + byt > 2000:
            print(f"{byt + len(line)} > 2000, Assert", flush=True)
            exit(-1)
        else:
            f.write(line)

subprocess.run(["./out/d8", f"{filename}"])

=== deploy/patches/README.md ===
build information
```
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

export PATH=`pwd`/depot_tools:"$PATH"
fetch v8
cd v8
./build/install-build-deps.sh
sudo apt-get install ninja-build

git checkout 6538a20aa097f9c05ead98eb88c71819aa1e65aa

gclient sync

git apply v8.patch

./tools/dev/gm.py x64.release
```

=== deploy/examples/example.js ===
console.log("AAAA")
<EOF>

=== deploy/out/args.gn ===
is_component_build = false
is_debug = false
target_cpu = "x64"
v8_enable_sandbox = true
use_goma = false
v8_enable_backtrace = true
v8_enable_disassembler = true
v8_enable_object_print = true
v8_enable_verify_heap = true
dcheck_always_on = false

=== flag_control/flag_reader (file type) ===
first bytes: 6f 6e 6c 79 20 66 6f 72 20 73 65 72 76 65 72 2e
length: 68
```

</div>
</details>

```python
Get-ChildItem "c:\Users\jshrb\Desktop\wargame-pwn\dh-exercise-v8\deploy\runner" -Force | Select-Object Name, Length; Write-Output "----- out top level -----"; Get-ChildItem "c:\Users\jshrb\Desktop\wargame-pwn\dh-exercise-v8\deploy\out" -Force | Where-Object { -not $_.PSIsContainer } | Select-Object Name, Length | Sort-Object Length -Descending | Select-Object -First 15
```

<details>
<summary markdown="span">결과</summary>
<div class="toggle-content" markdown="1">

```python
Name                               Length
----                               ------
run.sh                                 30
runner.py                             526
----- out top level -----
mksnapshot                       49739624
d8                               37007264
icudtl.dat                       10542048
torque                            3099728
.ninja_deps                       2839404
gen-regexp-special-case           1485328
bytecode_builtins_list_generator   620440
.ninja_log                         322931
snapshot_blob.bin                  273328
toolchain.ninja                    171763
build.ninja                         30634
build.ninja.d                        3725
v8_build_config.json                 1324
args.gn                               246
build.ninja.stamp                       0
```

</div>
</details>

run.sh, runner.py, [args.gn](http://args.gn/) 보기

- 중요한 건 `args.gn`에 `v8_enable_object_print=true`가 켜져 있어서, <strong>gdbinit 매크로가 호출하는 </strong>`_v8_internal_Print_*`<strong> 함수들이 </strong>`d8`<strong> 바이너리 안에 실제로 들어있다</strong>는 점
- `job`/`jco` 등이 동작

```python
wsl -d Ubuntu-24.04 -- bash -lc "cd /mnt/c/Users/jshrb/Desktop/wargame-pwn/dh-exercise-v8/deploy && ./out/d8 --version 2>&1; echo '---rev---'; strings -a out/d8 2>/dev/null | grep -iE 'Version [0-9]|v8 version|^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n 15"
```

<details>
<summary markdown="span">결과</summary>
<div class="toggle-content" markdown="1">

```python
Warning: unknown flag --version.
Try --help for options
V8 version 11.2.214.14
d8> 
---rev---
11.2.214.14
V8 version %s
```

</div>
</details>

`tools/gdbinit` + `tools/gdb-v8-support.py`  v8에서 다운로드

```python
#!/bin/bash
set -e
V=11.2.214.14
DST=/mnt/c/Users/jshrb/Desktop/wargame-pwn/dh-exercise-v8/debug
mkdir -p "$DST"
cd "$DST"
BASE="https://raw.githubusercontent.com/v8/v8/${V}/tools"
echo "downloading gdbinit ..."
curl -fsSL "${BASE}/gdbinit" -o gdbinit && echo "OK gdbinit" || echo "FAIL gdbinit"
echo "downloading gdb-v8-support.py ..."
curl -fsSL "${BASE}/gdb-v8-support.py" -o gdb-v8-support.py && echo "OK support" || echo "FAIL support"
echo "--- sizes ---"
wc -l gdbinit gdb-v8-support.py 2>/dev/null || true
echo "--- head gdbinit ---"
head -n 20 gdbinit 2>/dev/null || true

```

```python
wsl -d Ubuntu-24.04 -- bash "/mnt/c/Users/jshrb/AppData/Local/Temp/claude/c--Users-jshrb-Desktop-wargame-pwn/e9ce8d61-a9b1-4219-96ee-2cc6f73f68e5/scratchpad/dl-gdbinit.sh"
```

<details>
<summary markdown="span">결과</summary>
<div class="toggle-content" markdown="1">

```python
downloading gdbinit ...
OK gdbinit
downloading gdb-v8-support.py ...
OK support
--- sizes ---
  323 gdbinit
  248 gdb-v8-support.py
  571 total
--- head gdbinit ---
# Copyright 2014 the V8 project authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

# Print tagged object.
define job
call (void) _v8_internal_Print_Object((void*)($arg0))
end
document job
Print a v8 JavaScript object
Usage: job tagged_ptr
end

# Print content of v8::internal::Handle.
define jh
call (void) _v8_internal_Print_Object(*((v8::internal::Object**)($arg0).location_))
end
document jh
Print content of a v8::internal::Handle
Usage: jh internal_handle
```

</div>
</details>
