---
name: sales-training-video
description: Turn a sales skill (objection handling, discovery, cold-call opener, follow-up, closing) into a narrated 60-120s training video with a role-play scene, bad-vs-good comparison, recap and quiz, built in HyperFrames with a local voiceover and captions. Also makes 15s promo cutdowns. Use when asked for a "sales training video", "training module", "onboarding video for reps", "role-play video" or "promo for my sales course".
---

# Sales training video

Read `PLAYBOOK.md` in the claude-motion-video-kit repo first. This is the narrated-lesson variant of that process: the voiceover is the clock, not the music.

## Lesson structure (60-120s, 16:9 1920x1080, 60fps)

| # | Beat | Length | What is on screen |
|---|---|---|---|
| 1 | Hook | 5-8s | The mistake reps make, as one huge struck-through line or a real-looking call transcript snippet. Frame 0 already shows it. |
| 2 | Why it matters | 8-12s | One stat or consequence as a count-up or bar. Label made-up numbers "illustrative". |
| 3 | The framework | 15-25s | 3-4 steps max, each step one word + one line, built up on screen as the voice says it. |
| 4 | Role-play | 20-35s | Call UI or chat bubbles: PROSPECT vs REP lines appearing in sync with two different TTS voices. Highlight the technique as it happens. |
| 5 | Bad vs good | 10-15s | Split screen. Same prospect line, weak reply struck, strong reply lands. |
| 6 | Recap | 6-10s | The steps again as a checklist ticking off. |
| 7 | Quiz / practice | 6-10s | One question with 3 options, answer revealed after a 2s hold. End card with module number. |

## Run order

1. **Intake (one round):** skill/topic, who the learners are (SDR, AE, founder), product + typical prospect, 1-2 real objections or call lines, brand colours/logo, length, language/accent.
2. **Script first.** Write the full VO script + on-screen text per beat into `BRIEF.md`. Spoken at ~150 wpm, so 90s ≈ 225 words. Plain words, short sentences, no em dashes. Get a yes on the script before building anything.
3. **Voice:** `npx hyperframes tts` per beat (narrator e.g. `am_michael`, prospect e.g. `bf_emma`, rep e.g. `af_heart`; `--list` for all). Or ElevenLabs if a key exists. Concatenate, then `npx hyperframes transcribe` for word timings.
4. **Lock the timeline from word timings**, not guesses: every on-screen line lands on the frame its first word is spoken. Reading holds per PLAYBOOK §9.
5. **Build** (one subagent is fine, use the builder prompt from `motion-video` minus the reference section). One sub-composition per beat. Burned-in captions (bottom third, 2 lines max, keyword highlighted). Quiet music bed at about -28 LUFS under the voice, ducked; SFX only on reveals/ticks.
6. **Review stills** for every beat, then render. Check audio sync by watching it.
7. **Deliver:** the 16:9 lesson + an SRT (`transcribe --to srt`) + optional 9:16 cutdown of the role-play beat (`/reel-export`).

## Rules
- One skill per video. A series beats a long video.
- Role-play lines must sound like real calls: interruptions, short sentences, no robotic "Great question!".
- The rep's technique gets a visible label at the moment it happens (e.g. "LABEL THE CONCERN", "ASK, DON'T PITCH").
- Never use real prospect names, logos or recordings without permission.
