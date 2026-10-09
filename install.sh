#!/usr/bin/env bash
# Symlink skills from this repo into the places Claude Code loads them from.
# Safe to re-run. An existing real folder is moved to ~/.claude/skills-backup/ first.
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
COWORK="$HOME/Library/Mobile Documents/com~apple~CloudDocs/Cowork OS"
GLOBAL="$HOME/.claude/skills"
PERSONAL="$COWORK/Hobbies/.claude/skills"  # skipped if Cowork OS isn't on this machine
WORK="$HOME/Projects/.claude/skills"       # loads in non-git folders under ~/Projects

# Servier machines get global + work skills only, never personal ones.
SERVIER=0
if [[ "${USER_EMAIL:-}" == *@servier.com || "${CONNECT_SERVER:-}" == *servier.com* ]]; then
  SERVIER=1
fi

# skill path (relative to repo) | target skills directory [| link name, i.e. the /slash command]
LINKS=(
  "skills/notabene|$GLOBAL|nb"
  "third-party/cal-newport|$GLOBAL"
  "third-party/file-organizer|$GLOBAL"
  "skills/air-fryer|$PERSONAL"
  "skills/grocery-price-check|$PERSONAL"
  "skills/grocery-weekly-ad|$PERSONAL"
  "skills/work-intake|$WORK"
  "skills/work-update|$WORK"
)

for entry in "${LINKS[@]}"; do
  IFS='|' read -r path dir name <<< "$entry"
  name="${name:-$(basename "$path")}"
  src="$REPO/$path"
  dest="$dir/$name"
  if [[ "$dir" == "$PERSONAL" && "$SERVIER" == 1 ]]; then
    echo "skipped $name (personal skill, Servier system)"
    continue
  fi
  if [[ "$dir" == "$COWORK"* && ! -d "$COWORK" ]]; then
    echo "skipped $name (no Cowork OS folder on this machine)"
    continue
  fi
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
