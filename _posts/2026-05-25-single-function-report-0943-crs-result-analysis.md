---
layout: post
title: "single function report(..0943) CRS 결과 분석"
subtitle: ""
categories: ["📂/"]
tags: []
banner:
  image: ""
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

## 0943 취약점 요약: OOB(버퍼 밖 R/W)으로 인한 Heap based Buffer Over flow

<div class="box-warning" markdown="1">
#시나리오: badlen이 실제 라인 크기를 넘어서는 선택을 만들 수 있음

```javascript
badlen (spell_suggest 로컬)
  → su->su_badlen (구조체 필드로 복사)
    → 모든 하위 함수가 이걸 참조
```

이므로, 참조하는 모든 함수가 잠재적 sink → 
제로 OOB가 발생하려면 `su_badlen` 값을 버퍼 크기 검증 없이 메모리 접근에 사용하는 함수여야 해. `su_badlen`을 참조하되 단순 비교만 하는 함수(618, 666라인 같은)는 sink가 아님

`vim_strnsave()`가 내부적으로 `alloc()` (= `malloc()`)을 호출해서 힙에 메모리를 할당(힙에 할당된 버퍼)

`spell_find_suggest(line + cursor.col, badlen, ...)`로 넘어가서 `badlen`만큼 읽고 씀

읽기 → `badword_captype() // end 포인터가 badlen만큼 이동하여 버퍼 범위 밖을 읽음`

쓰기 → `vim_strncpy() //to[len] = NUL—> len이 badlen에서 유래된 값이라 버퍼 범위 밖에 NUL을 쓴다 `/`spell_casefold()//buf[outi] = NUL — 마찬가지로 badlen 기반 크기로 버퍼를 넘겨서 범위 밖에 씀`

패치 → 라인에 남은 실제 길이를 초과하면 잘라냄

```javascript
if (badlen > STRLEN(line) - curwin->w_cursor.col)
    badlen = STRLEN(line) - curwin->w_cursor.col;
```
</div>

src/spellsuggest.c 464 spell_suggest()에서 503 badlen 생성

```javascript

    if (VIsual_active)
    {
	// Use the Visually selected text as the bad word.  But reject
	// a multi-line selection.
	if (curwin->w_cursor.lnum != VIsual.lnum)
	{
	    vim_beep(BO_SPELL);
	    goto skip;
	}
	badlen = (int)curwin->w_cursor.col - (int)VIsual.col;
	if (badlen < 0)
	    badlen = -badlen;
	else
	    curwin->w_cursor.col = VIsual.col;
	++badlen;
	end_visual_mode();
	// make sure we don't include the NUL at the end of the line
	if (badlen > ml_get_curline_len() - (int)curwin->w_cursor.col)
	    badlen = ml_get_curline_len() - (int)curwin->w_cursor.col;
    }
```

```javascript
    else if (spell_move_to(curwin, FORWARD, SMT_ALL, TRUE, NULL) == 0
	    || curwin->w_cursor.col > prev_cursor.col)
    {
	// No bad word or it starts after the cursor: use the word under the
	// cursor.
	curwin->w_cursor = prev_cursor;
	char_u *curline = ml_get_curline();
	p = curline + curwin->w_cursor.col;
	// Backup to before start of word.
	while (p > curline && spell_iswordp_nmw(p, curwin))
	    MB_PTR_BACK(curline, p);
	// Forward to start of word.
	while (*p != NUL && !spell_iswordp_nmw(p, curwin))
	    MB_PTR_ADV(p);

	if (!spell_iswordp_nmw(p, curwin))		// No word found.
	{
	    beep_flush();
	    goto skip;
	}
	curwin->w_cursor.col = (colnr_T)(p - curline);
    }

```

```javascript
// Get the word and its length.

    // Figure out if the word should be capitalised.
    need_cap = check_need_cap(curwin, curwin->w_cursor.lnum,
							curwin->w_cursor.col);

    // Make a copy of current line since autocommands may free the line.
    line = vim_strnsave(ml_get_curline(), ml_get_curline_len());
    if (line == NULL)
	goto skip;

    // Get the list of suggestions.  Limit to 'lines' - 2 or the number in
    // 'spellsuggest', whatever is smaller.
    if (sps_limit > (int)Rows - 2)
	limit = (int)Rows - 2;
    else
	limit = sps_limit;
    spell_find_suggest(line + curwin->w_cursor.col, badlen, &sug, limit,
							TRUE, need_cap, TRUE);
```

src/spellsuggest.c 779 spell_find_suggest 804 	su->su_badlen = badlen;

```javascript
	su->su_badlen = badlen;
    else
	su->su_badlen = spell_check(curwin, su->su_badptr, &attr, NULL, FALSE);
```

<span class="highlight-red">**su_badlen 을 신뢰하는 모든 하위 함수가 sink가 됨**</span>

특히 vim_strncpy는 내용을 컨트롤 가능함(임의 주소 임의 쓰기) + spell casefold도

```javascript
    void
vim_strncpy(char_u *to, char_u *from, size_t len)
{
    STRNCPY(to, from, len);// len바이트(badlen)만큼 from→to 복사
    to[len] = NUL;
}
```

```javascript
    vim_strncpy(su->su_badword, su->su_badptr, su->su_badlen);
```

## 1. gpt5 분석

<details>
<summary><span class="highlight-yellow">**analysis-miniVim/singlemode/gpt-5_vim_2026-04-10T00:43:47.989027+00:00-report.jsonl 구조**</span></summary>
<div class="toggle-content" markdown="1">

```javascript
{
  "path": "strings.c",
  "fullname": "vim_strsave",
  "report": {
    "actions": [
      "calc(name=\"len\", expr=\"STRLEN(string) + 1\")",
      "alloc(name=\"p\", size=len, type=\"char_u *\")",
      "branch(condition=\"p != NULL\")",
      "read(name=\"string\", via=\"mch_memmove\", offset=0, size=len)",
      "write(name=\"p\", via=\"mch_memmove\", offset=0, size=len)",
      "return(name=\"p\", note=\"net-positive lifetime (caller must free)\")"
    ],
    "summary": "Allocate and copy NUL-terminated string, returning duplicate.",
    "sinks": [
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "STRLEN(string)"
      },
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "mch_memmove(p, string, len)"
      },
      {
        "category": "NullPointerDereference",
        "found": "yes",
        "source": "STRLEN(string)"
      },
      {
        "category": "IntegerOverflow",
        "found": "yes",
        "source": "len = STRLEN(string) + 1;"
      },
      {
        "category": "UseAfterFree",
        "found": "no"
      },
      {
        "category": "DoubleFree",
        "found": "no"
      },
      {
        "category": "UninitializedMemoryUse",
        "found": "no"
      },
      {
        "category": "MemoryLeak",
        "found": "no"
      },
      {
        "category": "FormatString",
        "found": "no"
      },
      {
        "category": "TypeConfusion",
        "found": "no"
      },
      {
        "category": "BusinessLogic",
        "found": "no"
      },
      {
        "category": "Backdoor",
        "found": "no"
      }
    ],
    "vulns": [
      {
        "category": "OutOfBoundsAccess",
        "source": "STRLEN(string)",
        "reason": "Unbounded scan may read past valid memory if string lacks NUL"
      },
      {
        "category": "NullPointerDereference",
        "source": "STRLEN(string)",
        "reason": "string NULL leads to immediate dereference in STRLEN"
      },
      {
        "category": "IntegerOverflow",
        "source": "len = STRLEN(string) + 1;",
        "reason": "Adding 1 to very large length can wrap size_t for alloc"
      }
    ],
    "invariants": [
      {
        "name": "string_nonnull",
        "condition": "string != NULL",
        "category": "NullPointerDereference"
      },
      {
        "name": "string_nul_terminated",
        "condition": "string is NUL-terminated within accessible memory",
        "category": "OutOfBoundsAccess"
      },
      {
        "name": "size_no_overflow",
        "condition": "STRLEN(string) < SIZE_MAX",
        "category": "IntegerOverflow"
      },
      {
        "name": "memmove_preconditions",
        "condition": "if p != NULL then p points to at least len bytes",
        "category": "OutOfBoundsAccess"
      }
    ]
  },
  "vulns": [
    "category: OutOfBoundsAccess\nreason: Unbounded scan may read past valid memory if string lacks NUL\nsource: STRLEN(string)\n",
    "category: NullPointerDereference\nreason: string NULL leads to immediate dereference in STRLEN\nsource: STRLEN(string)\n",
    "category: IntegerOverflow\nreason: Adding 1 to very large length can wrap size_t for alloc\nsource: len = STRLEN(string) + 1;\n"
  ]
}
```

</div>
</details>

#### 1-1. vim-mini

<div class="box-warning" markdown="1">
vim-mini: sink 정의(spell, spellsuggest, strings(vim)) + buffer관리(memline)으로 선정
</div>

```javascript
cat /workspace/data/cve-2022-0943/analysis-miniVim/singlemode/gpt-5_vim_*-report.jsonl | python3 -c "
import sys, json
for line in sys.stdin:
    obj = json.loads(line)
    path = obj.get('path','')
    name = obj.get('fullname','')
    vulns = obj.get('report',{}).get('vulns',[])
    sinks = obj.get('report',{}).get('sinks',[])
    if vulns:
        print(f'\n=== {path} :: {name} ===')
        for v in vulns:
            print(f'  [{v.get(\"category\",\"?\")}] {v.get(\"reason\",\"\")[:150]}')
        found_sinks = [s for s in sinks if s.get('found') in ('yes','possible')]
        if found_sinks:
            print(f'  sinks ({len(found_sinks)} found): {[s[\"category\"] for s in found_sinks]}')
" > /workspace/data/cve-2022-0943/analysis-miniVim/singlemode/gpt5_vulns_summary_v2.txt
```

vulns<sinks임 항상 사유: LLM이 실제 위험하다고 생각한 것만 / sinks는 코드 패턴이 존재하는지를 보고

/workspace/data/cve-2022-0943/analysis-miniVim/singlemode/gpt5_vulns_summary_v2

#### 1-1-(1) sink 탐지 

```javascript
=== strings.c :: vim_strncpy ===
  [OutOfBoundsAccess] Copies len bytes without validating source/destination sizes; may read or write past buffers.
  [OutOfBoundsAccess] Writes a terminator at index len; requires destination to be at least len+1 bytes.
  sinks (4 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'NullPointerDereference', 'NullPointerDereference']
```

```javascript
=== spell.c :: init_syl_tab ===
  [IntegerOverflow] Casting size_t difference to int can overflow; later used as size_t length in vim_strncpy.
  [IntegerOverflow] Casting size_t to int can overflow; later used as size_t length in vim_strncpy.
  [OutOfBoundsAccess] If l overflows negative to large size_t, copy writes past syl->sy_chars despite SY_MAXLEN check.
  sinks (5 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'IntegerOverflow', 'IntegerOverflow']
```

```javascript
=== spell.c :: spell_casefold ===
  [OutOfBoundsAccess] off-by-one write when outi == buflen due to missing space for terminator
  [OutOfBoundsAccess] may read past str+len on final truncated multibyte sequence; no end bound provided
  sinks (5 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'NullPointerDereference', 'IntegerOverflow']

```

```javascript
=== spell.c :: fold_more ===
  [OutOfBoundsAccess] Destination pointer uses mi_fword + mi_fwordlen and size MAXWLEN - mi_fwordlen without validating mi_fwordlen; negative/oversized values can cause wri
  [OutOfBoundsAccess] Reads from mi_fword + mi_fwordlen without ensuring prior null-termination; can scan past buffer end if not terminated.
  [IntegerOverflow] Casting pointer difference to int and computing MAXWLEN - mi_fwordlen may overflow/underflow, leading to incorrect sizes passed to spell_casefold.
  sinks (9 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'NullPointerDereference', 'NullPointerDereference', 'IntegerOverflow', 'IntegerOverflow', 'UninitializedMemoryUse']

```

```javascript
=== spellsuggest.c :: badword_captype ===
  [OutOfBoundsAccess] Only p < end is checked; multibyte decoding can read past end if end splits a character or remaining bytes are insufficient.
  [OutOfBoundsAccess] Advancing over a multibyte character may read beyond end to determine character length when end is not on a character boundary.
  sinks (3 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess']
```

#### 1-1-(2) badlen, su_badlen

```javascript
=== spellsuggest.c :: spell_suggest ===
  [IntegerOverflow] Length can become negative when stp->st_orglen > sug->su_badlen + stp->st_wordlen, leading to wrap or mis-sized copy and potential out-of-bounds acces
  sinks (8 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'NullPointerDereference', 'IntegerOverflow', 'IntegerOverflow']
=== spellsuggest.c :: spell_find_suggest ===
  [OutOfBoundsAccess] su->su_badlen may be caller-supplied (badlen != 0) and is only clamped to MAXWLEN, not validated against readable bytes at su->su_badptr, enabling ove
  [OutOfBoundsAccess] End pointer uses untrusted length and may point past accessible memory, leading to over-read in callee.
  [OutOfBoundsAccess] Casefolding reads su->su_badlen bytes from su->su_badptr; untrusted length can exceed available source bytes.
  sinks (7 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess', 'OutOfBoundsAccess', 'NullPointerDereference', 'NullPointerDereference', 'IntegerOverflow', 'BusinessLogic']
=== spellsuggest.c :: spell_suggest_expr ===
  [NullPointerDereference] su is dereferenced unconditionally; if su is NULL this will crash.
  [UseAfterFree] If get_spellword returns p pointing into list storage and add_suggestion retains p without copying, later processing dereferences freed memory.
  [OutOfBoundsAccess] If add_suggestion uses su->su_badlen to read from p without validating p’s length.
  sinks (4 found): ['NullPointerDereference', 'NullPointerDereference', 'UseAfterFree', 'OutOfBoundsAccess']
```

#### 1-2. vim-full

## 2. gpt 5.4 mini 분석

#### 2-1. vim-mini

#### 2-1-(1). sink 분석 

```javascript
=== strings.c :: vim_strncpy ===
  [OutOfBoundsAccess] destination size is not checked before copying len bytes
  [OutOfBoundsAccess] writes one byte past the copied region unless to has space for len + 1 bytes
  sinks (2 found): ['OutOfBoundsAccess', 'OutOfBoundsAccess']
```

```javascript
spell_casefold 분석 없음
{
  "path": "spell.c",
  "fullname": "spell_casefold",
  "report": {
    "actions": [
      "branch(condition=\"len >= buflen\")",
      "write(name=\"buf\", type=(char_u *), offset=0, size=1)",
      "return(value=\"FAIL\")",
      "branch(condition=\"has_mbyte\")",
      "loop(condition=\"p < str + len\", effect=\"fold one multibyte character at a time\")",
      "branch(condition=\"outi + MB_MAXBYTES > buflen\")",
      "write(name=\"buf\", type=(char_u *), offset=\"outi\", size=1)",
      "return(value=\"FAIL\")",
      "read(name=\"p\", type=(char_u *), offset=0, size=\"mb_cptr2char_adv advances through str\")",
      "branch(condition=\"c == 0x03a3 || c == 0x03c2\")",
      "branch(condition=\"p == str + len || !spell_iswordp(p, wp)\")",
      "write(name=\"buf\", type=(char_u *), offset=\"outi\", size=\"mb_char2bytes(c, buf + outi)\")",
      "write(name=\"buf\", type=(char_u *), offset=\"outi\", size=1)",
      "loop(condition=\"i < len\", effect=\"copy folded byte from spelltab\")",
      "read(name=\"str\", type=(char_u *), offset=\"len-1\", size=1)",
      "write(name=\"buf\", type=(char_u *), offset=\"len-1\", size=1)",
      "write(name=\"buf\", type=(char_u *), offset=\"len\", size=1)"
    ],
    "summary": "Folds spelling text into a destination buffer with bounds checks.",
    "sinks": [
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "buf[0] = NUL;"
      },
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "buf[outi] = NUL;"
      },
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "buf[i] = spelltab.st_fold[str[i]];"
      },
      {
        "category": "OutOfBoundsAccess",
        "found": "yes",
        "source": "buf[i] = NUL;"
      },
      {
        "category": "NullPointerDereference",
        "found": "no",
        "source": "buf[0] = NUL;"
      },
      {
        "category": "NullPointerDereference",
        "found": "no",
        "source": "buf[outi] = NUL;"
      },
      {
        "category": "NullPointerDereference",
        "found": "no",
        "source": "buf[i] = spelltab.st_fold[str[i]];"
      },
      {
        "category": "NullPointerDereference",
        "found": "no",
        "source": "buf[i] = NUL;"
      },
      {
        "category": "UseAfterFree",
        "found": "no",
        "source": "buf[0] = NUL;"
      },
      {
        "category": "IntegerOverflow",
        "found": "no",
        "source": "if (len >= buflen)"
      },
      {
        "category": "IntegerOverflow",
        "found": "no",
        "source": "if (outi + MB_MAXBYTES > buflen)"
      },
      {
        "category": "TypeConfusion",
        "found": "no",
        "source": "c = mb_cptr2char_adv(&p);"
      },
      {
        "category": "MemoryLeak",
        "found": "no",
        "source": "return FAIL;"
      },
      {
        "category": "FormatString",
        "found": "no",
        "source": "buf[0] = NUL;"
      },
      {
        "category": "BusinessLogic",
        "found": "no",
        "source": "if (c == 0x03a3 || c == 0x03c2)"
      },
      {
        "category": "Backdoor",
        "found": "no",
        "source": "if (c == 0x03a3 || c == 0x03c2)"
      }
    ],
    "vulns": [],
    "invariants": [
      {
        "name": "destination_capacity",
        "condition": "buflen is the actual size of buf in bytes",
        "category": "OutOfBoundsAccess"
      },
      {
        "name": "nonnegative_lengths",
        "condition": "len >= 0 and buflen >= 0",
        "category": "IntegerOverflow"
      },
      {
        "name": "source_bounds",
        "condition": "str points to at least len readable bytes",
        "category": "OutOfBoundsAccess"
      },
      {
        "name": "spelltab_initialized",
        "condition": "spelltab.st_fold is initialized for all byte values",
        "category": "UninitializedMemoryUse"
      },
      {
        "name": "mbyte_helpers_safe",
        "condition": "mb_cptr2char_adv and mb_char2bytes respect buffer and string boundaries",
        "category": "OutOfBoundsAccess"
      }
    ]
  },
  "vulns": []
}
```

```javascript
=== spellsuggest.c :: badword_captype ===
  [OutOfBoundsAccess] The loop advances p by multibyte character width until p reaches end; if end is not a valid boundary for a complete character, decoding can read past 
  sinks (1 found): ['OutOfBoundsAccess']
```

#### 2-2. vim-full 

## 3. 1, 2 모델별 차이 분석

#### 3-1. vim-mini

- 찾은 함수 자체는 5.4-mini가 더 많은데, reference를 잘 못잡는 경향(그런데 reference를 찾을 수 있다는 거 자체도 놀랍다)
  /workspace/data/cve-2022-0943/analysis-miniVim/singlemode/gpt5-5.4-mini-func-diff.txt

```javascript
4d3 //라인
< === memline.c :: attention_message ===  //gpt 5에만 있는 함수
6a6,8
> === memline.c :: check_need_swap === //5.4에만 있는 함수
> === memline.c :: crypt_may_close_swapfile ===
> === memline.c :: do_swapexists ===
8d9
< === memline.c :: fnamecmp_ino ===
10d10
< === memline.c :: goto_byte ===
15c15,16
< === memline.c :: ml_append_flush ===
---
> === memline.c :: ml_add_stack ===
> === memline.c :: ml_append_buf ===
16a18
> === memline.c :: ml_check_b0_id ===
18a21
> === memline.c :: ml_close_notmod ===
21c24
< === memline.c :: ml_delete_flags ===
---
> === memline.c :: ml_delete_int ===
24a28
> === memline.c :: ml_firstmarked ===
25a30
> === memline.c :: ml_get_buf ===
27c32
< === memline.c :: ml_get_curline ===
---
> === memline.c :: ml_get_curline_len ===
28a34
> === memline.c :: ml_get_pos ===
30a37
> === memline.c :: ml_line_alloced ===
32,33c39,40
< === memline.c :: ml_new_ptr ===
< === memline.c :: ml_preserve ===
---
> === memline.c :: ml_open_file ===
> === memline.c :: ml_open_files ===
35d41
< === memline.c :: ml_replace ===
38d43
< === memline.c :: ml_set_crypt_key ===
39a45
> === memline.c :: ml_setmarked ===
42d47
< === memline.c :: ml_upd_block0 ===
46c51,52
< === memline.c :: swapfile_info ===
---
> === memline.c :: set_b0_dir_flag ===
> === memline.c :: set_b0_fname ===
48,49d53
< === memline.c :: swapfile_unchanged ===
< === spell.c :: advance_camelcase_word ===
55,57c59
< === spell.c :: clear_midword ===
< === spell.c :: close_spellbuf ===
< === spell.c :: compile_cap_prog ===
---
> === spell.c :: clear_spell_chartab ===
59a62
> === spell.c :: dump_prefixes ===
61a65,66
> === spell.c :: expand_spelling ===
> === spell.c :: ex_spelldump ===
69a75
> === spell.c :: int_wordlist_spl ===
72d77
< === spell.c :: match_compoundrule ===
73a79,80
> === spell.c :: no_spell_checking ===
> === spell.c :: onecap_copy ===
75,77c82
< === spell.c :: slang_alloc ===
< === spell.c :: slang_free ===
< === spell.c :: spell_casefold ===
---
> === spell.c :: slang_clear ===
81d85
< === spell.c :: spell_delete_wordlist ===
83d86
< === spell.c :: spell_expand_check_cap ===
84a88
> === spell.c :: spell_iswordp_nmw ===
86d89
< === spell.c :: spell_load_cb ===
89,90c92
< === spell.c :: spell_reload ===
< === spell.c :: spell_soundfold ===
---
> === spell.c :: spell_move_to ===
96a99
> === spell.c :: valid_spellfile ===
98d100
< === spellsuggest.c :: add_banned ===
107a110
> === spellsuggest.c :: prof_init ===
109a113
> === spellsuggest.c :: rescore_suggestions ===
115d118
< === spellsuggest.c :: spell_check_sps ===
124d126
< === spellsuggest.c :: spell_suggest_intern ===
130c132,133
< === spellsuggest.c :: suggest_try_soundalike_finish ===
---
> === spellsuggest.c :: suggest_try_soundalike ===
> === spellsuggest.c :: suggest_try_soundalike_prep ===
135d137
< === strings.c :: blob_from_string ===
137a140,141
> === strings.c :: copy_first_char_to_tv ===
> === strings.c :: csh_like_shell ===
140d143
< === strings.c :: f_byteidx ===
142d144
< === strings.c :: format_overflow_error ===
146d147
< === strings.c :: f_strchars ===
149,150d149
< === strings.c :: f_strlen ===
< === strings.c :: f_strpart ===
152,156d150
< === strings.c :: f_strtrans ===
< === strings.c :: f_strutf16len ===
< === strings.c :: f_strwidth ===
< === strings.c :: f_tr ===
< === strings.c :: f_trim ===
159d152
< === strings.c :: has_non_ascii ===
164d156
< === strings.c :: skip_to_arg ===
165a158
> === strings.c :: sort_strings ===
167,170d159
< === strings.c :: string_filter_map ===
< === strings.c :: string_from_blob ===
< === strings.c :: string_quote ===
< === strings.c :: string_reduce ===
174a164
> === strings.c :: tv_str ===
195d184
< === strings.c :: vim_strup ===

```
