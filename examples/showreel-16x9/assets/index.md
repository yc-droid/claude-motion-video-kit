# Assets

> Music and SFX are not stored in this repo. Run `sh scripts/fetch-example-assets.sh` from the kit root to download and trim them exactly as below.

## Music
- `music/minimal-techno-02-15s.wav` (used): 15.000s cut of **"Minimal Techno 02"**, Mixkit (track #161).
  - Source page: https://mixkit.co/free-stock-music/tag/techno/
  - Direct file: https://assets.mixkit.co/music/161/161.mp3 (the fetch script saves it as `music/original.mp3`)
  - Licence: Mixkit Free License (free for commercial and personal use, no attribution required). https://mixkit.co/license/#musicFree
  - Edit: trimmed from 28.152s for 15.0s (bar 1 = the 2-beat break, the drop hits the bar 2 cut), 4ms fade-in, EBU R128 loudnorm to -15 LUFS / -1.5 dBTP, 48 kHz PCM. 15ms fade-out in the composition. The cut is musically seamless when looped (both ends sit on a bar line of the same groove).
  - Tempo 128.0 BPM (beat 0.46875s, bar 1.875s), first downbeat 0.00s. Grid in `../beats.json`.

## SFX
HyperFrames media-use bundled library (`~/.claude/skills/media-use/audio/assets/sfx/`, offline): whoosh, whoosh-short, click, click-soft, impact-bass-1.

## Fonts (local, deterministic, all SIL OFL 1.1)
- `fonts/Montserrat-Var.ttf` (kinetic type, bar 2 and bar 7), Google Fonts.
- `fonts/SourceSerif4-Var.ttf` (wordmark, bar 8), Google Fonts.
- `fonts/Barlow-600.ttf`, `fonts/Barlow-700.ttf` (frame labels, tracked caps), Google Fonts.
- `fonts/JetBrainsMono-400.woff2`, `fonts/JetBrainsMono-700.woff2` (readouts, timecode).

## Runtime libraries (CDN, loaded at page load, pinned)
- GSAP 3.14.2 (jsdelivr), Three.js 0.181.2 (jsdelivr, bar 5 point cloud).
