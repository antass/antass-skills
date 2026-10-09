# antass-skills

Ania's custom Claude skills — one source of truth.

## Skills

| Skill | What it does | Runs in | How it's installed |
|---|---|---|---|
| `notabene` (`/nb`) | "btw …" asides → timestamped bullet in Notion daily log | Claude Code (global) | symlink via `install.sh` |
| `air-fryer` | Oven → air fryer conversion, cook & defrost settings (Cosori TurboBlaze) | Claude Code (Hobbies folder) | symlink via `install.sh` |
| `grocery-price-check` | 6-store price check for 02128 → Notion grocery guide | claude.ai / Cowork | upload zip |
| `grocery-weekly-ad` | Weekly ad via Flipp → aisle-sorted deal list | claude.ai / Cowork | upload zip |
| `work-intake` | Email/Teams request → scoped Work project + Notion tasks | claude.ai / Cowork | upload zip |
| `work-update` | Route new info into an existing Work project | claude.ai / Cowork | upload zip |

`third-party/` — skills written by others:
- `cal-newport` — Cal Newport deep-work persona (manual `/cal-newport`) · Claude Code (global), symlinked via `install.sh`
- `file-organizer` — organize folders, find duplicates, cleanup · Claude Code (global), symlinked via `install.sh`
- `cowork-os` — Cowork OS plugin by Paul J Lipsky (`begin`, `memory-create`, `memory-delete`, `subfolders`)
- `critical-code-reviewer` — by Garrick Aden-Buie, MIT

## Workflows

**New machine / after cloning**
```bash
./install.sh
```

**Edit a Claude Code skill** — edit `skills/<name>/SKILL.md` (or `third-party/<name>/`) here; it's live immediately (symlinked). Then commit.

**Edit a claude.ai skill** — edit here, then:
```bash
./package.sh grocery-price-check
```
and upload `dist/grocery-price-check.zip` in claude.ai → Settings → Capabilities → Skills (replace the existing one).

**Add a new skill** — create `skills/<name>/SKILL.md`, add a row above, and either add it to `LINKS` in `install.sh` (Claude Code) or package + upload (claude.ai).
