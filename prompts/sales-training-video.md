# Paste-ready prompts: sales training videos

Open Claude Code in an empty folder (after running `scripts/setup.sh`), fill in the `[brackets]`, paste.

---

## Prompt 1: a training lesson (60-120s, narrated)

```
Use the /sales-training-video skill and the playbook in [path to claude-motion-video-kit]/PLAYBOOK.md.

Make a [90]-second sales training video for my reps.

Topic: [handling the "we already have a vendor" objection]
Learners: [new SDRs, first 30 days, calling US mid-market companies]
What we sell: [one line on the product and price range]
Typical prospect: [title, company type]
Real lines I hear on calls: ["We're happy with who we use." / "Send me an email."]
The technique I want taught: [acknowledge, get curious, find the gap, ask for a small next step]
Brand: [colours as hex, logo file path or "unbranded"]
Voice: [American male narrator, British female prospect]

Structure: hook, why it matters, the framework, a role-play call between prospect and rep, bad reply vs good reply, recap checklist, one quiz question.

Process I want:
1. Write the full voiceover script and on-screen text per beat into BRIEF.md and show it to me. Do not build until I approve the script.
2. Generate the voices locally with hyperframes tts, transcribe for word timings, lock the timeline to the words.
3. Build in HyperFrames at 1920x1080 60fps with burned-in captions and a quiet music bed.
4. Show me stills of every beat before rendering. Then render, and give me the MP4, an SRT file and a 9:16 cut of the role-play.

Quality bar: it should look like a well-designed course video, not a slideshow. Follow the playbook craft rules: something moves on every beat, no dead time, no glows, gradients or confetti, plain words, no em dashes.
```

---

## Prompt 2: a 15s promo for the sales training (for X / LinkedIn / Reels)

```
Use the /motion-video skill and [path to claude-motion-video-kit]/PLAYBOOK.md.

Make a 15-second, 60fps motion video promoting my sales training: [program name, one line on who it's for and the result].

Use the "problem to payoff" structure from the playbook (see examples/argument-1x1):
- Bar 1: the problem as a word or line that gets struck through: [e.g. "Reps winging cold calls"]
- Bar 2: the payoff word on a full colour field: [e.g. "Scripts that book meetings"]
- Bar 3: a grid stat going from bad to good: [e.g. "connect-to-meeting rate 4% to 11%", label it illustrative if it isn't measured]
- Bar 4: a count-up of [meetings booked / reps trained]
- Bar 5: a fast strobe of the 4 modules: [module names]
- Bar 6: end card with [name, CTA like "Reply TRAIN for the first module"]

Format: [1080x1080 for X and LinkedIn], with a matching 9:16 export for Reels.
Brand: [hex colours, fonts if any, or "pick a clean editorial look with one accent colour"].
Music around 123 BPM from Mixkit with cuts on the downbeats, SFX on the strikes.

Show me the bar table and stills before rendering. Then render, verify with ffprobe, and give me 3 post captions (no em dashes, one asks for replies).
```

---

## Tips
- Make a **series**: one skill per lesson (opener, discovery, objections, booking the meeting, follow-up). Reuse the same BRIEF.md design section so they look like one course.
- Edit with the 4-field format: `At 0:42 (role-play, rep line 2) / the label appears before he says it / move it to the first word of "what made you" / keep the voice and layout as they are.`
- Want a real person on camera instead? Record the role-play and use video-use (PLAYBOOK §1) to cut it, then add the HyperFrames labels and captions on top.
