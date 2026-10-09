#!/usr/bin/env bash
# Zip a skill for upload to claude.ai (Settings → Capabilities → Skills).
# Usage: ./package.sh grocery-price-check   → dist/grocery-price-check.zip
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
name="${1:?usage: ./package.sh <skill-name>}"
mkdir -p "$REPO/dist"
rm -f "$REPO/dist/$name.zip"
(cd "$REPO/skills" && zip -rq "$REPO/dist/$name.zip" "$name" -x '*.DS_Store')
echo "dist/$name.zip"
