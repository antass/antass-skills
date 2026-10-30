---
name: worklog
description: "Record what was actually done in a working session into the current project's worklog.md — shipped commits, work in flight, dead ends, blockers, and the next action — then close out the matching Notion tasks. Auto-invoke when Ania is wrapping up and says something like 'log this session', 'what did we get done', 'wrap up', 'end of day', or 'write that up before I forget'. Also invoked directly as /worklog. This skill records work that WENT OUT of the session — things Ania and Claude did. It is NOT for information coming IN from outside (a follow-up email, a spec change, a stakeholder decision, a new dataset) — that is `work-update`, and if both could apply, split the material and say which half went where. Do not invoke for a passing thought to stash (`nb`), or to start a new project (`work-intake`)."
argument-hint: "[optional: a date range to read back, e.g. 'last week']"
---

# Work Log — session record

Ania finishes a session and the knowledge of what happened starts decaying immediately. A week later she knows the code changed but not why she abandoned the other approach, and re-tries it.

Your job is to write down **what this session actually did**, in the project it was done in, with evidence. Not a recap — she was there. A record for the version of her who comes back in three weeks.

The failure mode is a plausible-sounding summary of work that didn't happen. **Everything you log must be anchored to something you can point at** — a commit, a diff, a command output you saw. Where you can't, say the thing is unverified or leave it out.

---

## STEP 1 — RESOLVE THE PROJECT

The log goes in the project the session ran in, found from the current directory:

1. `git rev-parse --show-toplevel` — if inside a repo, that's the project root.
2. Otherwise, walk up from cwd for the nearest ancestor containing `CLAUDE.md`.
3. Otherwise, cwd itself.

The project name is that directory's basename. Target file: `<project root>/worklog.md`.

**Refuse to log into a non-project.** If the resolved root is `$HOME`, `~/Projects`, `/`, or `/tmp`, stop and ask which project she means. A worklog in a home directory is a worklog nobody finds.

Say the resolved project in one line before going further, so a wrong guess is caught early.

---

## STEP 2 — GATHER EVIDENCE

**Do this before recalling the conversation.** Git is the ground truth; your memory of the session is the commentary on it.

Each entry records the `HEAD` it was written at, so the window since the last entry is exact:

- Read the top entry of `worklog.md` for its `**HEAD:**` sha. If there is one, the window is `git log <sha>..HEAD --oneline`. If there's no file or no sha, fall back to commits since 06:00 today, and say that's what you did.
- `git status --short` and `git diff --stat` — uncommitted work.
- `git branch --show-current`.
- `date "+%Y-%m-%d %H:%M"` — never hardcode or estimate the date.

Then read the session for the things git cannot show:

- **What was tried and abandoned, and why.** This is the highest-value line in the whole file and the only place it exists — git records what was kept, never what was rejected.
- **What is blocked, and on whom.**
- **What the next action is.**

If the project is not a git repo, work from the conversation and from file mtimes, and mark the entry `**Evidence:** conversation only` so its reliability is on the record.

---

## STEP 3 — CLASSIFY, AND DON'T DUPLICATE

The project already has places for most of this. The worklog is the chronology; it **cross-references** the others rather than restating them.

| What came out of the session | Goes to |
|---|---|
| What shipped, what's in flight, dead ends, blockers, next action | `worklog.md` — this skill |
| A choice that was made, and why | `decisions.md` — `work-update` |
| A dataset or file now in play | `sources.md` — `work-update` |
| A change to what's true about the project now | `CLAUDE.md` §State — `work-update` |
| A task finished, or newly created | Notion — step 6 |
| Routine work with nothing durable in it | Nowhere. Say so and stop. |

For anything in the middle rows, do not write those files yourself — name them in the entry's `**Also filed:**` line and tell Ania they're a `work-update` job. One skill owning `decisions.md` is the reason it's still readable.

**An empty session is a real answer.** If nothing durable happened — reading code, a failed experiment that taught nothing, a conversation that went nowhere — say "nothing worth logging" and write no entry. A file of no-op entries is how a worklog becomes unreadable by week six.

---

## STEP 4 — DRAFT, AND GATE

Show the entry exactly as it will be written, then one gate: go / adjust / drop. One gate only — don't confirm sections individually.

```markdown
## YYYY-MM-DD — <headline: what this session was about, one line>
**HEAD:** <sha> (branch `<branch>`)

**Shipped**
- <what changed, in terms of behaviour not files> — `<sha>`

**In flight**
- <uncommitted work, with the file and roughly how much>

**Tried, didn't work**
- <approach> — <why it failed, concretely enough not to re-try it>

**Blocked**
- <what, on whom, since when>

**Next**
- <the single next action, named concretely>

**Also filed:** decisions.md ×2, CLAUDE.md §State
```

Rules for the draft:

- **Omit every section that's empty.** No "N/A", no empty headers. Most entries are three sections.
- **Shipped lines describe behaviour, not files.** "Partial runs no longer warn" beats "modified app.py and cli.py". The sha covers the files.
- **Every Shipped line carries a sha.** No sha means it isn't shipped — it's In flight.
- **Never log a test as passing unless you saw it pass this session.** If tests weren't run, don't mention tests.
- **The headline is the thing she'll scan.** Make it the substance of the session, not "various fixes".
- If a same-day entry already exists, title this one `## YYYY-MM-DD HH:MM — <headline>` so the two don't read as one.

---

## STEP 5 — WRITE

Newest entry directly under the file header. Create the file on first use with exactly this header:

```markdown
# Work Log — <Project Name>

Session-by-session record of what was done here. Newest first.
Decisions and their rationale live in `decisions.md`; datasets in `sources.md`.
```

Then the entry. Never rewrite or tidy existing entries — they're a record, including the parts that turned out wrong. If an earlier entry was mistaken, the correction belongs in today's entry, not in an edit to the old one.

---

## STEP 6 — NOTION

Notion is provided globally by the `notion-workspace-plugin` MCP server. It may not be authenticated in a given session.

If the Notion tools are available:

- **Tasks** data source `collection://1f4cd6cc-cf0e-81c4-9788-000b8095c344` — find tasks on this project matching what shipped and set `Status` → `Done`. Match conservatively: if you aren't confident a task is the one that shipped, leave it and say so.
- Create tasks for the **Next** and **Blocked** items — `Task` (title), `Status` (`Not started`, or `Waiting` if blocked on someone else), `Type` (`Task`), `Priority`, `Projects` (relation), `Date Added` (today). Nothing from **Tried, didn't work** becomes a task.
- **Projects** data source `collection://1f4cd6cc-cf0e-8113-8c1b-000b19ce189a` — update `Status` only if the session actually moved it.

If the Notion tools are **not** available: write the local entry anyway, append `<!-- notion: unsynced -->` on its last line, and say in one line that Notion wasn't reachable and nothing was synced. **Never report a sync that didn't happen.** On a later run, offer to clear the backlog of `unsynced` entries.

---

## STEP 7 — REPORT

Four lines maximum: the file written, how many Notion tasks closed and created, anything that needs `work-update`, and the next action. She was there for the session; don't recap it back.

---

## CATCH-UP MODE

If Ania passes a range (`/worklog last week`, "what did I do on PrismBreaker this month") or asks to read rather than write: **read only, write nothing.**

Read `worklog.md` for the period and answer the question she actually asked. If she's after a cross-project view, check the sibling projects under the same parent folder for their own `worklog.md`. Lead with the answer; quote entries only where the detail matters.

---

## RULES

- Evidence before memory. Git first, conversation second.
- Never log work you can't point at. Uncommitted is In flight, never Shipped.
- Dead ends are the point. The approach that failed is the thing no other file records.
- Never invent a *why*. "Not stated" is a real answer, same as in `work-update`.
- Never rewrite an old entry. Corrections go in today's.
- Never touch `decisions.md`, `sources.md`, or `CLAUDE.md` from this skill — name them and hand off.
- Never claim a Notion sync that didn't happen.
- Nothing durable, no entry. One gate, then write.
