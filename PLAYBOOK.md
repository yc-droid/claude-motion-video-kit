# AI Motion Video Playbook

What we learned building motion-design videos with Claude Code + HyperFrames. Three real builds, two rejections, one "pretty good". Everything below is what survived.

---

## 1. How it works

- No AI "makes" these videos. **Claude writes the video as code** (HTML + CSS + GSAP, Three.js for 3D) and **HyperFrames renders it**: headless Chrome jumps to each frame, screenshots it, ffmpeg stitches frames + audio into an MP4.
- Every frame is a pure function of time, so output is exact and repeatable. Same files in, same video out.
- Code video is great at kinetic type, numbers, charts, UI, diagrams, 3D shapes, transitions. It cannot make photoreal footage. For that use a generative model (Seedance, Kling, Veo via fal.ai) and composite the clip into HyperFrames.

### The 8 layers of any AI video

| Layer | Tool | Notes |
|---|---|---|
| Script / plan | Claude Code | the director |
| Coded visuals | **HyperFrames** (Apache 2.0, free) | Remotion is the React alternative but needs a paid company licence for teams over 3 |
| Music | Mixkit (free licence, no attribution) | direct mp3s at assets.mixkit.co |
| SFX | HyperFrames `media-use` bundled library | ~19 files, works offline |
| Voice | `npx hyperframes tts` (local Kokoro, free) or ElevenLabs | |
| Captions | `npx hyperframes transcribe` (Parakeet / Whisper, local) | |
| Generated footage | Seedance / Kling / Veo | only for hero shots, expensive to iterate |
| Assembly | ffmpeg | under everything |

Editing **real footage** (talking heads, podcasts, recorded role-plays): [video-use](https://github.com/browser-use/video-use) (MIT). The agent reads a word-level transcript, writes a cut list, ffmpeg renders.

---

## 2. The process that works

**Fastest route to a good video: replicate one proven viral post, then swap in your content.** Our from-scratch v1 was rejected as "template level". The replica (v3) was the best of three on first render.

1. **Pick ONE proven reference** close to the format you want. Don't invent from scratch.
   Galleries: oneshotted.io · motionpromptgallery.com · revid.ai/claude-motion-graphics · github.com/yihui-dev/awesome-opus5-5-videos · claudevideo.org
2. **Pull it apart** (commands in §6): post JSON, MP4, contact sheet, cut timings.
3. **Write a per-bar table:** time · background colour · technique · the through-line object.
4. **Map each bar to one piece of YOUR message.** Keep the grammar (bar length, palette, through-line), swap the content.
5. **Write the timeline as frame numbers in `BRIEF.md`** (§9).
6. **Build with one subagent** using the builder prompt in `skills/motion-video/SKILL.md`. It studies the reference frames, builds, and compares side-by-side stills against the reference.
7. **Review stills yourself** (2 per bar) before rendering. Never render blind.
8. **Render** (§4), watch with sound, give director notes, re-render.

What failed: v1 had 2 scenes, a 3s static hold, 30fps, no audio, simple easing. It passed every lint check and was still not worth posting. "Passes checks" is not the bar. "Would I repost this" is.

---

## 3. Craft rules (the quality floor)

- **60fps with motion blur.** Springs with at most a tiny overshoot. No bounce easing.
- **Something moves on every beat.** No static hold over ~1.2s except the end card (and reading holds, §9).
- **Real music ~120-128 BPM; hard cuts land on downbeats** (1 bar at 128 BPM = 1.875s). SFX on strikes, snaps and cuts, kept under the music.
- **Designer frame:** tiny mono labels in the corners (title, BPM, bar counter, timecode, crop marks).
- **Type:** one bold grotesk for kinetic words, an italic serif accent, mono for metadata. Huge hero words.
- **1-2 accent colours.** Example showreel palette: black, vermilion, cream, cobalt, yellow.
- **One object threads through the whole piece** (e.g. a red dot) and pays off at the end (becomes the period of the wordmark).
- **Last frame matches the first** so autoplay loops are seamless.
- **Banned:** particles/confetti, glows, gradients on UI, everything-centred-fades-in, dead time, generic grey wireframes.
- **On-screen copy:** plain words, no em dashes. Label made-up stats "illustrative".

### Proven structures

| Structure | Reference | Use for |
|---|---|---|
| **Showreel:** 8 bars × 1.875s, new colour + technique per bar, through-line dot → wordmark | @ajith_io, @stephanlivera | capability reels, "look what we can do" |
| **Problem → payoff:** word struck → payoff word on colour field → grid stat bad% → good% → count-up → strobe → end card | @deedydas | one specific argument (see `examples/argument-1x1`) |
| **Continuous morph:** one UI shape never cuts, morphs through 12 states on a 120 BPM grid | @twoclipping | product / UI demos |
| **Narrated lesson** (60-120s): hook → concept → role-play → bad vs good → recap → quiz | (ours, see `prompts/`) | sales training, onboarding, explainers |

---

## 4. Rendering

| Option | Command | When |
|---|---|---|
| **Local** (default) | `PRODUCER_BROWSER_GPU_MODE=hardware npx hyperframes render . -q high -o renders/x.mp4` | one-off videos |
| HeyGen cloud | `npx hyperframes cloud render` (needs `npx hyperframes auth`) | no local Chrome/ffmpeg |
| AWS Lambda | `npx hyperframes lambda deploy` then `lambda render <dir>` | many variants, fast fan-out |
| Google Cloud Run | `npx hyperframes cloudrun deploy --project <id>` then `render` / `render-batch` | batch on GCP |
| Shareable preview | `npx hyperframes publish .` (private by default) | send an interactive preview, not an MP4 |

**Local benchmarks (M2 Mac):** 15s 30fps 1080 square ≈ 2m15s · 15s 60fps + motion blur ≈ 5-10 min · 16:9 60fps with 3D ≈ 5 min, 66 MB.
Small copy for WhatsApp/Slack: `ffmpeg -i in.mp4 -c:v libx264 -crf 28 -preset slow -c:a aac -b:a 128k small.mp4`
Vertical Reel/TikTok version: `/reel-export` skill.

### Gotchas
- An extra root `.html` with `data-composition-id` (like a backup `index.v1.html`) fails `check`. Keep backups outside the project.
- `npx hyperframes beats` once misread a 120 BPM track as 375 BPM. Sanity-check the grid; fall back to librosa/numpy.
- `snapshot --describe` needs `GEMINI_API_KEY`. Skip it and read the contact sheets yourself.
- Projects pin a CLI version. Run `npx hyperframes@latest upgrade --project . --check` before re-rendering old projects.
- HyperFrames needs **paused, finite timelines**. Ignore generic GSAP advice about `play()`, `repeat: -1` or ScrollTrigger.
- Fonts: ship them locally in `assets/fonts/` (deterministic renders). No network at render time, no unseeded `Math.random`.

---

## 5. Posting on X / LinkedIn

- Video must be **over 10s** to earn video-view credit on X. 15s is the sweet spot.
- Scroll-past is penalised: **frame 0 must already show the hook.**
- Shares and replies are worth far more than likes. Write copy that asks for a reply ("Reply REEL and I'll send the breakdown").
- Smaller accounts get a cold-start boost in the first ~2h. Reply to every comment in that window.
- Attach video natively. Put links in a follow-up reply.
- Quote-tweeting the viral post you replicated (with your version attached) borrows its context and invites the original author in.
- US audience: post 9-11am or 1-3pm ET.

---

## 6. Commands cheat sheet

```bash
# Grab a reference from X (study only, don't republish other people's work)
curl -s https://api.fxtwitter.com/<user>/status/<id> -o post.json     # text, likes, views, mp4 url
curl -sL "<video.twimg.com mp4 url>" -o ref.mp4
ffmpeg -i ref.mp4 -vf "fps=2,scale=320:-1,tile=6x5" -frames:v 1 sheet.jpg                                   # contact sheet
ffmpeg -i ref.mp4 -vf "select='gt(scene,0.3)',showinfo" -f null - 2>&1 | grep -o "pts_time:[0-9.]*"       # cut times
ffprobe -v error -show_entries stream=codec_type,width,height,r_frame_rate -of compact ref.mp4

# New project
npx hyperframes init videos/<name> --non-interactive --example=blank --skill=motion-graphics

# Build loop (inside the project)
npx hyperframes check .
npx hyperframes snapshot --at 0.3,1.5,2.3       # contact sheet in snapshots/, READ it
npx hyperframes preview --background            # Studio in the browser; stop with --stop
PRODUCER_BROWSER_GPU_MODE=hardware npx hyperframes render . -q high -o renders/<name>.mp4

# Audio
npx hyperframes tts script.txt -v am_michael -o assets/vo.wav   # local voiceover (--list for voices)
npx hyperframes transcribe assets/vo.wav                        # word timings for captions (--to srt for a sidecar)
npx hyperframes beats .                                         # beat grid for the music track
```

CLI features worth knowing: `capture <url>` (grab a website for product videos), `remove-background`, `compare` (variants side by side), `timeline`, `history` (undo), `benchmark`.

---

## 7. Toolbox (audited)

| Need | Use |
|---|---|
| Composition + render | HyperFrames (default) |
| Animation | GSAP (default), Anime.js, Lottie, Three.js, CSS/WAAPI: all built into HyperFrames adapters |
| GSAP plugins (SplitText, MorphSVG, DrawSVG, Flip, CustomEase) | official `greensock/gsap-skills` |
| Maths / diagram explainers (3Blue1Brown style) | ManimGX: `manimgx render scene.py Scene` → MP4 1080p60, composite into HyperFrames |
| Captions | `npx hyperframes transcribe` (Parakeet or Whisper) |
| Voiceover | `npx hyperframes tts` (Kokoro, local) or ElevenLabs |
| SVG cleanup | `npx svgo in.svg -o out.svg` before animating logos/icons |
| Skipped | Remotion (licence), Motion Canvas (second renderer), React-three stack (React-only), Theatre.js (unmaintained), Howler (HF does audio) |

---

## 8. Using subagents

- One builder subagent per video works well **if the prompt names the exact skill files to read** (hyperframes-core, hyperframes-animation blueprints, motion principles, motion-blur reference) and **forbids rendering until stills are reviewed**.
- A full replica build takes ~30 min + ~5 min render.
- Use HyperFrames blueprints (`kinetic-type-beats`, `grid-card-assemble`, `agent-progress-theater`, ...) and search the registry before hand-building any named effect.

---

## 9. Frame-number direction

- **Write the timeline as frame numbers in `BRIEF.md`:** card lands, cursor approach, press, reveal, reading-hold start/end, close. At 60fps, 1s = 60f.
- **One event per shot:** start state → cursor on target → press → result → hold.
- **Reading holds start when text is legible**, not when it starts animating. Read it aloud at normal speed to size the hold. 8 frames is not a hold.
- **Sound on event frames:** click on the press frame, hit on the reveal frame.
- **Craft:** ~0.1s stagger headline → label; subtle 1.00 → 1.03 push; blur only on entrances; quiet background during holds.
- **Review 3 stills first** (opening, result, close), then motion.
- **Edit prompts in 4 fields:** where (time/frame + element) · what's wrong · the change · what must stay fixed.
- `BRIEF.md` also holds: goal, assets, layout coordinates + colours, max lines per headline (test the longest one).
