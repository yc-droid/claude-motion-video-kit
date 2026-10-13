#!/bin/sh
# Music and SFX are not redistributed in this repo (Mixkit licence + HyperFrames bundle).
# This downloads/copies them so the two examples render exactly as built.
set -e
KIT=$(cd "$(dirname "$0")/.." && pwd)
SFX_SRC="$HOME/.claude/skills/media-use/audio/assets/sfx"
[ -d "$SFX_SRC" ] || { echo "Run scripts/setup.sh first (HyperFrames media-use skill provides the SFX)."; exit 1; }

music() { # dir url start_seconds lufs out_name
  d="$KIT/examples/$1/assets/music"; mkdir -p "$d"
  curl -fsSL "$2" -o "$d/original.mp3"
  ffmpeg -y -loglevel error -ss "$3" -t 15 -i "$d/original.mp3" \
    -af "afade=t=in:d=0.008,loudnorm=I=$4:TP=-1.5" -ar 48000 -c:a pcm_s16le "$d/$5"
  echo "  $1: $5"
}
sfx() { # dir files...
  d="$KIT/examples/$1/assets/sfx"; mkdir -p "$d"; shift
  for f in "$@"; do cp "$SFX_SRC/$f.mp3" "$d/"; done
}

music showreel-16x9 https://assets.mixkit.co/music/161/161.mp3 28.152 -15 minimal-techno-02-15s.wav
sfx   showreel-16x9 whoosh whoosh-short click click-soft impact-bass-1
music argument-1x1  https://assets.mixkit.co/music/133/133.mp3 31.311 -16 dub-techno-groove-15s.wav
sfx   argument-1x1  whoosh whoosh-short click click-soft key-press pop impact-bass-1
echo "Done. cd examples/<name> && npx hyperframes preview"
