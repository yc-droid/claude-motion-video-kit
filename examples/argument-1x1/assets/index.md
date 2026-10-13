# Assets

> Music and SFX are not stored in this repo. Run `sh scripts/fetch-example-assets.sh` from the kit root to download and trim them exactly as below.

## Music
- `music/dub-techno-groove-15s.wav` (used) - 15.000s cut of **"Dub Techno Groove"** by Alejandro Magaña (A. M.), Mixkit.
  - Source page: https://mixkit.co/free-stock-music/tag/techno/
  - Direct file: https://assets.mixkit.co/music/133/133.mp3 (the fetch script saves it as `music/original.mp3`)
  - Licence: Mixkit Free License (free for commercial and personal use, no attribution required). https://mixkit.co/license/#musicFree
  - Edit: trimmed from 31.311s (the drop downbeat) for 15.0s, 8ms fade-in, EBU R128 loudnorm to -16 LUFS / -1.5 dBTP, 48 kHz PCM. Fade-out is done in the composition (volume automation, last 0.4s).
  - Tempo 123.0 BPM (beat 0.4878s); first downbeat at 0.020s. Full grid in `../beats.json`.

## SFX
From the HyperFrames media-use bundled library (`~/.claude/skills/media-use/audio/assets/sfx/`, offline, bundled with the skill):
whoosh, whoosh-short, click, click-soft, key-press, pop, impact-bass-1 (plus unused: impact-bass-2, ping).

## Fonts (local woff2, deterministic)
- `fonts/InterTight-Var.woff2` - Inter Tight variable (wght 100-900), Google Fonts, SIL OFL 1.1.
- `fonts/InstrumentSerif-Italic.woff2` - Instrument Serif Italic, Google Fonts, SIL OFL 1.1.
- `fonts/JetBrainsMono-400.woff2`, `fonts/JetBrainsMono-700.woff2` - JetBrains Mono, SIL OFL 1.1.
