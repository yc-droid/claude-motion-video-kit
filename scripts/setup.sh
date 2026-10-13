#!/bin/sh
# One-time setup: HyperFrames skills, a few extra skills, and this kit's own skills for Claude Code.
set -e
KIT=$(cd "$(dirname "$0")/.." && pwd)

need() { command -v "$1" >/dev/null 2>&1 || { echo "Missing: $1. $2"; exit 1; }; }
need node   "Install Node 22+ (https://nodejs.org or 'brew install node')."
need ffmpeg "Install ffmpeg ('brew install ffmpeg' or your package manager)."
need claude "Install Claude Code: https://code.claude.com/docs/en/overview"

echo "1/4 HyperFrames skills (renderer + motion, audio, captions, registry)"
npx --yes hyperframes skills

echo "2/4 Extra skills: brand intake, launch video, prompt writer, reel export (charlie947, MIT)"
for s in brand-intake launch-video motion-prompt-writer reel-export; do
  npx --yes skills add charlie947/motion-graphics-skills --skill "$s" || echo "  (skipped $s, install it by hand later)"
done

echo "3/4 This kit's skills -> ~/.claude/skills"
mkdir -p "$HOME/.claude/skills"
cp -R "$KIT/skills/"* "$HOME/.claude/skills/"

echo "4/4 Optional: faster, more accurate captions (Parakeet)"
npx --yes hyperframes models install parakeet || echo "  (skipped, captions will use Whisper)"

echo
echo "Done. Next:"
echo "  sh $KIT/scripts/fetch-example-assets.sh   # music + SFX for the two examples"
echo "  open $KIT/prompts/sales-training-video.md # paste a prompt into Claude Code"
