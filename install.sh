#!/usr/bin/env bash
# Symlink skills from this repo into the places Claude Code loads them from.
# Safe to re-run. An existing real folder is moved to ~/.claude/skills-backup/ first.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
COWORK="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Cowork OS"

# skill path (relative to repo) -> target skills directory
LINKS=(
  "skills/quick-thought-capture|$HOME/.claude/skills"
  "skills/air-fryer|$COWORK/Hobbies/.claude/skills"
  "third-party/cal-newport|$HOME/.claude/skills"
  "third-party/file-organizer|$HOME/.claude/skills"
)

for entry in "${LINKS[@]}"; do
  path="${entry%%|*}"
  dir="${entry#*|}"
  name="$(basename "$path")"
  src="$REPO/$path"
  dest="$dir/$name"
  mkdir -p "$dir"
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -e "$dest" ]; then
    # Back up outside the skills dir so Claude doesn't load a duplicate.
    backup="$HOME/.claude/skills-backup/$(date +%Y%m%d)"
    mkdir -p "$backup"
    mv "$dest" "$backup/$name"
    echo "backed up $dest -> $backup/$name"
  fi
  ln -s "$src" "$dest"
  echo "linked $name -> $dir"
done
