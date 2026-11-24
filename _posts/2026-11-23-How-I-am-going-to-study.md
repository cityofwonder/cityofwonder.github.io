---
layout: post
title: "[etc] How I'm going to study (and how I should)"
subtitle: ""
top: 1
categories: ["📂/etc/"]
tags: ["paper reading", "mindset"]
status: "작성완료"
notion: true
notion_id: "420bb540-e5fe-80a6-9976-cd29425047a2"
notion_synced: "2026-11-23T17:11:00.000Z"
banner:
  image: "/assets/images/2026-11-23/How-I-am-going-to-study-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

<details>
<summary markdown="span">Highlighting Rules</summary>
<div class="toggle-content" markdown="1">

Each format has one job. Read the post once, then skim a single color to follow one thread.

- <span class="highlight-blue"><strong>Blue</strong></span> - rules I'm committing to
- <span class="highlight-yellow">Yellow</span> - the one-line takeaway of a section
- <span class="highlight-orange">Orange</span> - where things break for me right now
- <span class="highlight-green">Green</span> - hunches and bets I haven't tested yet
- <span class="text-yellow">Amber text</span> - terms I define once and keep reusing
- <span class="text-gray">Gray text</span> - time budgets, examples, and asides
- 💡 box - the one idea the rest of the post hangs on

</div>
</details>

<strong>TL;DR:</strong> I keep falling down rabbit holes when I read papers and dig into 1-days. So in this post I lay out what I actually want to get good at, what keeps tripping me up, and the reading routine I'm switching to: extract by default, and only derive where it really matters.

## What I actually want, in detail

1. What I ultimately want:
   1. To explain anything I know simply enough that someone outside the field gets it. I also want people in my field to actually enjoy hearing me explain things, and to find me congenial to work with.
   1. To have the creativity and drive to stand shoulder to shoulder with the best people in my field.
   1. To be both congenial and genuinely good, so I don't slide into laziness or get stuck in a Thucydides-trap kind of anxiety, and can <span class="highlight-yellow">keep myself going on pride for the rest of my life</span>.
1. What I'm building my research around (or plan to):
   1. Ideally I'd work on something that hits all three of the below, but that's hard. <span class="highlight-blue"><strong>So I look for overlap between i and ii, and put in enough honest effort on iii that I'm not dragging my teammates down.</strong></span> I should also list out why the three don't overlap yet, and whenever one of those gets resolved, move that topic into the overlap and make it a priority.
      1. Research that gets papers written
      1. Research that just feels cool to me
      1. Research that counts toward the lab's grant projects
   1. i
      - compilation•quantization•GPU backdoor

        This area only picked up in late 2025 and 2026, so there aren't many papers yet. <span class="highlight-green">I think I'd get more into it once I start checking feasibility as I study.</span>
   1. i, ii
      - DLSCA
      - automated fuzzer/CRS for AI infra vulnerabilities
   1. iii
      - model fingerprinting

        My stats and linear algebra background isn't strong enough yet. <span class="highlight-orange">I try to understand every equation line by line, but honestly that seems to be what's slowing me down.</span>
1. Vulnerability classes and platforms I want to analyze:
   1. Windows userland and kernel

      Because MSRC's top researchers look really cool. Also, I want to dig into something with a higher barrier to entry than the Linux kernel.
   1. Big-name bugs that blew up in 2026, like nginx2root and copyfail

      These don't fit into a single class. They're individual bugs that got names because of how much damage they could do. But if I treat "high-impact bugs" as a category of its own and start there, <span class="highlight-green">I think I'll pick up fundamentals across a bunch of classes, and get a gut feeling for how people find good bugs in the first place.</span>
   1. Vulnerabilities in AI infra platforms

      It's close to my major, and <span class="highlight-green">I think it'll fill in at least one of the many angles I need to really understand AI.</span>

## What keeps getting in my way?

1. When I read papers
   1. <span class="highlight-orange">I keep getting stuck on individual terms and falling down rabbit holes</span> <span class="text-gray">(set-value problem, tiling, Goto's algorithm)</span>.
      1. I know papers build on earlier work, so there's no way I'll know every prerequisite before I start.
      1. So I try to separate out the <span class="text-yellow">substrate</span> where I can and queue some terms for later, but then it feels like I'm reading a paper full of holes, and I can't focus.
         1. If I queue one term and move on, the paper keeps bringing it back in slightly mutated forms. Those turn into holes too, and <span class="highlight-orange">pretty soon I've lost track of how the whole paper fits together</span>.
   1. Even if I fix (a), there's a pile of harder questions left. How do I read a huge appendix? How am I supposed to understand the math?
      1. <span class="highlight-orange">These punch so many holes in the paper that I can't just queue them all and move on.</span>
   1. Given what I'm going for, <span class="highlight-blue"><strong>everything I read or run should end up as something written</strong></span>.
      1. <span class="highlight-orange">But when it takes more than 6 hours to get to that final artifact, it starts to feel inefficient.</span>
      1. <span class="text-gray">Even though I know the extra time usually pays off.</span>
1. When I analyze 1-days
   1. Same story as papers. I want to understand every detailed interaction from the entry point all the way to the sink, and <span class="highlight-yellow">I end up with the same rabbit holes and the same feeling that I'm wasting time</span>.

## So what am I going to do about it?

<div class="box-note" markdown="1">
💡 <strong>Two reading modes</strong>

- <span class="text-yellow">Extraction</span> - "What does it claim? What's the core object? What's the result?" <span class="text-gray">(the what)</span>
- <span class="text-yellow">Derivation</span> - "Why does it hold? Why is each step right?" <span class="text-gray">(the why)</span>
- <span class="highlight-yellow">The inefficiency comes from running derivation where extraction would've been enough.</span>
</div>

<details>
<summary markdown="span">Reading papers</summary>
<div class="toggle-content" markdown="1">

<strong>0. Pick</strong> <span class="text-gray">(~5min)</span>

- From Scholar Inbox or dblp. <span class="text-yellow">Spine</span> topics first <span class="text-gray">(DLSCA, AI-infra CRS = i∩ii)</span>, or deliberately pick one from ii
- <span class="highlight-blue"><strong>Decide the tier before reading</strong></span>: <span class="text-yellow">card</span> (one shallow read) vs <span class="text-yellow">deep</span> (one deep read). Default is card
- Output: a stub row in the blog DB - title + one-line "why picked" + tier, status set to in progress

<strong>1. Skeleton pass</strong> <span class="text-gray">(~15-20min · extraction mode)</span>

- abstract → last paragraph of the intro (contributions) → figure captions → section titles → conclusion
- Read the abstract, contributions, and conclusion word by word and carefully, but <strong>to extract</strong>. Skim titles and captions for structure only
- <span class="highlight-blue"><strong>Don't resolve unknown terms - just mark them on a "spine candidates" list and keep going</strong></span>
- Output: 3-5 spine items (core objects/claims/results), the spine-candidate term list, and one "what &amp; why" paragraph
- <strong>Gate</strong>: if it's card tier, stop here → TL;DR + spine is already a complete short post
- Post increment: intro / TL;DR section

<strong>2. Substrate resolve</strong> <span class="text-gray">(candidates only, each with bounded depth)</span>

- Sort the spine candidates into two buckets:
  - <span class="text-yellow"><strong>substrate</strong></span> <span class="text-gray">(tiling, Goto's algorithm, set-value, etc. - has its own textbook chapter and shows up across papers)</span> → learn it separately from linear material outside the paper. If it's big enough, it becomes <strong>its own NTM post</strong>
  - <span class="text-yellow"><strong>paper-local</strong></span> <span class="text-gray">(specific to this paper)</span> → resolve it from the paper's setup/method, with bounded depth
- This fixes the reason parking used to wreck the structure (core concepts coming back in mutated forms). <span class="highlight-yellow">The spine is already visible after the skeleton pass, so it gets resolved, and only leaves get parked.</span> If a parked term keeps showing up during the deep read, that's the signal to promote it
- Post increment: NTM spin-off (linked from the main post)

<strong>3. Deep read - core method</strong> <span class="text-gray">(extraction → targeted derivation)</span>

- Method/core sections only. First, at the block level, ask "what does this do?" (extraction) → then go line by line on just the 1-2 key equations behind the contribution (derivation)
- <span class="highlight-blue"><strong>Don't read the appendix front to back - when I need to audit a specific claim, read just that section, on demand</strong></span>
- <span class="text-yellow"><strong>Reviewer lens</strong></span>: find the assumptions the results lean on, and the weakest point <span class="text-gray">(this is research-level reading, and it's the meat of the post)</span>
- Post increment: "how it works" section + "weakest point / critique" section

<strong>4. (Optional) Reproduce / experiment</strong> - only if it's spine and I'm building something on top of it

- Output: experiment section + a reusable eval setup

<strong>5. Post</strong> <span class="text-gray">(stitch + one editing pass)</span>

- The sections are already there, so it's ~80% done. Stitch them together, add sources, and that's it
- Final shape: TL;DR (what/why) → (NTM links) → method → weakest point/critique → (experiments) → takeaway

</div>
</details>

<details>
<summary markdown="span">1-days → 1day series posts <span class="text-gray">(same shape)</span></summary>
<div class="toggle-content" markdown="1">

- <strong>0. Pick</strong> - recent ones with a public PoC first, then decide the tier
- <strong>1. Call-chain skeleton</strong> - map the entry point → sink at the <strong>function-name level</strong> only (extraction). Don't look inside each function yet
- <strong>2. Substrate resolve</strong> - OS fundamentals like "how does IOCTL dispatch get called?" get learned separately, outside the CVE. No relearning them for every CVE
- <strong>3. Deep read</strong> - <span class="highlight-blue"><strong>go deep on just the one function where the bug lives</strong></span>, plus the PoC/trigger. <span class="highlight-yellow">Trying to read the whole chain at full depth is exactly where the rabbit holes come from</span>
- <strong>4. 1day post</strong> - call-chain diagram + bug root cause + PoC analysis

</div>
</details>
