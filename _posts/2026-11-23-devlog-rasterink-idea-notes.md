---
layout: post
title: "[Devlog; rAsterink] Idea notes"
subtitle: "Idea · Planning a lightweight PDF note app for reading papers"
top: 2
categories: ["📂/oss-Devlog/rAsterisk/"]
tags: ["PDF annotation", "note-taking", "paper reading"]
status: "작성완료"
notion: true
notion_id: "421bb540-e5fe-80a4-8455-c0af740f816f"
notion_synced: "2026-11-23T17:33:00.000Z"
banner:
  image: "/assets/images/2026-11-23/devlog-rasterink-idea-notes-banner.png"
  opacity: 0.5
  background: "rgba(0, 0, 0, 0.7)"
---

<details>
<summary markdown="span">Highlighting Rules</summary>
<div class="toggle-content" markdown="1">

Each format has one job. Read the post once, then skim a single color to follow one thread.

- <span class="highlight-blue"><strong>Blue</strong></span> - design decisions I'm sticking with
- <span class="highlight-yellow">Yellow</span> - the one-line takeaway of a section
- <span class="highlight-orange">Orange</span> - pain points the app has to fix
- <span class="highlight-green">Green</span> - ideas I haven't decided on yet
- <span class="text-yellow">Amber text</span> - terms I keep reusing
- <span class="text-gray">Gray text</span> - examples, numbers, and asides
- 💡 box - the one question the app is built around

</div>
</details>

TL;DR: When I queue up unfamiliar terminology in a paper and keep going, the paper ends up full of holes like Swiss cheese (punching holes), and the actual content and the relationships I need to follow get lost in the fog.

![](/assets/images/2026-11-23/devlog-rasterink-idea-notes-4036f3c7.png)

But <span class="highlight-orange">if I dig into each one, I fall down a rabbit hole</span>. <span class="highlight-yellow">I figured the key to fixing this was a good note-taking tool.</span> So I started planning one: something that doesn't break my train of thought, saves me from flipping back and forth to find where I left off, and still looks nice and stays lightweight.

### 0. rAsterink overview

<strong>rAsterink</strong> - a lightweight, open-source PDF note-taking app for the Galaxy Tab S11, built around reading papers

- rasters: images made of dots, a stack of data + link: connecting those pieces of data organically
- Asterism: a pattern of stars. The links between rasters become an asterism in the universe that is your brain. <span class="text-gray">It's also a nod to being the asterisk on your research.</span>
- ink: what makes it a note-taking app

![](/assets/images/2026-11-23/devlog-rasterink-idea-notes-0f9f9055.png)

### 1. sketch

- Where it started: 
  - I need an app for annotating PDF papers on my Galaxy Tab 11. None of the existing apps felt like they were made for taking notes on papers.
    - Especially: <span class="highlight-orange">no way to resize the canvas</span>
    - <span class="highlight-orange">They crash once the notes pile up</span>, which gets old fast
  - <span class="highlight-blue"><strong>Start with a lightweight app focused on taking notes on papers</strong></span>, not a general-purpose notes app.
- Requirements:

  1. On papers with an OCR text layer, mark each term listed in the config with an assigned shape = <span class="text-yellow"><strong>punching</strong></span>
  1. Sync with Zotero on my laptop, so punching can show up as a specific annotation type in Zotero
  1. Lightweight writing. A pen that feels like a ballpoint, with just the right pressure response
  1. Resize the canvas on PDF import, with whatever color and template I want

  <figure class="img-pair">
      <div class="img-pair-row">
        <img src="/assets/images/2026-11-23/devlog-rasterink-idea-notes-0822d694.png" alt="">
        <img src="/assets/images/2026-11-23/devlog-rasterink-idea-notes-242823e8.png" alt="Requirements">
      </div>
      <figcaption style="font-size: 0.9em; color: gray; margin-top: 5px;" markdown="span">Requirements</figcaption>
  </figure>

### 2. Core question and goal

<div class="box-note" markdown="1">
💡 <strong>What's on a researcher's desk?</strong>

A computer, a tablet, and a paper notebook. All three live on the same desk.
</div>

- So the note-taking app I have in mind <span class="highlight-blue"><strong>isn't trying to cut down on or replace the computer</strong></span>. <span class="text-gray">(Not optimizing for convenience, portability, etc.)</span>
- I just want to build <span class="highlight-yellow">a tool that cuts the waste that comes from juggling all three: doing things twice, hunting for stuff, and jumping back and forth between pages of a paper</span>.
- In other words
  - When typing is faster, I use the laptop → <span class="highlight-blue"><strong>only minimal transfer between devices</strong></span>
  - <span class="highlight-blue"><strong>No standalone requirement</strong></span>: I'm not designing for "it should work with just the tablet"

### 3. Design principles

- <span class="highlight-blue"><strong>Lightweight</strong></span>
  - → Writing: keep coordinate math to a minimum → it should hold up even as files get big
  - <span class="notion-comment">→ Good compatibility (device fit?) → Galaxy Tab (Android) + laptop only<span class="comment-bubble"><span class="comment-item">💬 It has to actually run well on the devices it supports. GoodNotes does support the Galaxy Tab, but it crashes, lags, and has stroke delay.</span></span></span>
- <span class="highlight-blue"><strong>No stutter</strong></span> → smooth animated transitions + good pen feel
- <span class="highlight-blue"><strong>No feature path deeper than 2</strong></span> <span class="text-gray">(every feature is within two steps. Partly to stay light, and partly because I don't want a complicated tool)</span>

### 4. Features

1. Zotero sync (one-way) // Punching

   <strong>Zotero sync</strong>

   - Direction: <span class="highlight-blue"><strong>laptop → Tab (one-way)</strong></span>
   - Zotero is used only for <span class="text-yellow">spine</span>, <span class="text-yellow">substrate</span>, etc.

   <strong>Punching</strong>

   - Sort out the spine first → <span class="highlight-blue"><strong>index it so the same word always gets the same mark</strong></span>
     - Same meaning gets the same mark too (synonyms included)
   - Everything else: substrate
   - Extract annotations into Notion through the Zotero-Notion link → so they can be managed like a wiki
     - <span class="highlight-orange">Common words (e.g. "attack") show up hundreds of times in a single paper</span> → rules need options like `max_hits` and `first_only`
1. PDF only + custom canvas
   - No blank notes. <span class="highlight-blue"><strong>Everything starts from a PDF import</strong></span>

     + canvas resizing / custom templates for page background color and margins
   - <span class="highlight-green">Open question: is full customization too heavy? → Alternative: n preset colors</span>
1. Focus mode
   - Show how long it's been since I opened the paper, in the top-right corner
     - <span class="highlight-green">What if it handed out a "read a paper today" badge, showed it on a heatmap view, and let me share it to Instagram Stories?</span>
   - + Do Not Disturb button
1. Writing (pen)
   - Lightweight writing. Pressure response like a ballpoint pen
   - Ballpoint feel = a narrow stroke-width range <span class="text-gray">(e.g. 0.85~1.15x)</span>
   - Values to tune: pressure curve (gamma), stroke-width range, smoothing, stroke-start stability
   - <span class="highlight-yellow">Feel is subjective, so I pin it down with numbers.</span> Tweak it with in-app sliders and save the values I like as presets
