# Claude Motion Video Kit

Make motion-design videos with Claude Code: showreels, promo clips and narrated sales-training lessons. Claude writes each video as code (HTML + GSAP), and [HyperFrames](https://github.com/heygen-com/hyperframes) renders it to MP4 on your own machine. The core tools are free and open source.

This repo collects what we learned from real builds: the process that works, the quality rules, two complete example projects, Claude Code skills and paste-ready prompts.

## What's inside

| Path | What it is |
|---|---|
| [`PLAYBOOK.md`](PLAYBOOK.md) | **Start here.** How it works, the process, craft rules, proven structures, rendering, posting, commands |
| [`prompts/sales-training-video.md`](prompts/sales-training-video.md) | Paste-ready prompts: a 90s narrated training lesson + a 15s promo for your sales training |
| `skills/motion-video/` | Claude Code skill: replicate a viral reference video, swap in your message |
| `skills/sales-training-video/` | Claude Code skill: narrated lesson with role-play, bad vs good, recap, quiz |
| `examples/showreel-16x9/` | 15s 16:9 60fps showreel, 8 bars on a 128 BPM grid (source) |
| `examples/argument-1x1/` | 15s 1:1 60fps "problem to payoff" argument piece (source) |
| `scripts/setup.sh` | Installs HyperFrames skills, extra skills and this kit's skills |
| `scripts/fetch-example-assets.sh` | Downloads the music + SFX the examples use (not redistributed here) |

## Setup (about 10 minutes)

You need: macOS or Linux, [Node 22+](https://nodejs.org), ffmpeg, and [Claude Code](https://code.claude.com/docs/en/overview).

```bash
git clone https://github.com/<owner>/claude-motion-video-kit.git
cd claude-motion-video-kit
sh scripts/setup.sh
sh scripts/fetch-example-assets.sh
```

Check it works by previewing an example:

```bash
cd examples/argument-1x1
npx hyperframes preview          # opens the Studio in your browser
npx hyperframes render . -q high -o renders/test.mp4
```

## Make your first video

1. Read [`PLAYBOOK.md`](PLAYBOOK.md) (15 minutes, worth it).
2. Make a new empty folder, open Claude Code in it, and paste a prompt from [`prompts/sales-training-video.md`](prompts/sales-training-video.md) with your details filled in.
3. Approve the script or bar table, review the stills, then let it render.

## The 5 rules that matter most

1. **Copy a proven reference, don't invent one.** Replicating one viral post and swapping in your content beat every from-scratch attempt.
2. **Stills before render.** Review 2 stills per scene, and never render blind.
3. **60fps, motion blur, cuts on the beat.** Something moves on every beat, with no dead time.
4. **No template look.** No glows, gradients, confetti or bounce easing, and not everything centred and fading in.
5. **Plain words on screen.** Short lines, no em dashes, and made-up numbers labelled "illustrative".

## Credits and licences

- Kit content (playbook, skills, prompts, example source): MIT, see [LICENSE](LICENSE).
- [HyperFrames](https://github.com/heygen-com/hyperframes) (Apache 2.0) by HeyGen. Extra skills from [charlie947/motion-graphics-skills](https://github.com/charlie947/motion-graphics-skills) (MIT).
- Example fonts are SIL OFL 1.1 (Google Fonts, JetBrains Mono). Music comes from [Mixkit](https://mixkit.co/license/#musicFree) under its free licence and is downloaded by the script, not stored here.
- Structures studied from public posts by @ajith_io, @stephanlivera, @deedydas and @twoclipping. Study references, but don't republish other people's videos.
