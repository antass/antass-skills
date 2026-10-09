---
name: work-update
description: "Route new information into an existing Cowork OS Work project — a follow-up email, meeting decision, data file, spec change, result, or blocker gets filed to the right place across CLAUDE.md, decisions.md, sources.md, intake/, and Servier OS Notion."
---

# Work Update — Mid-Flight Intake

Companion to `work-intake`. That skill starts projects; this one keeps them true.

Work doesn't arrive in one clean request. It arrives as a follow-up email three days later, a decision made in a hallway, a dataset that turned out to have a column that doesn't exist, a stakeholder quietly moving the deadline. **Your job is deciding where each piece of information belongs so it's findable in six weeks** — not summarizing it back into the chat scroll where it dies.

---

## STEP 1 — IDENTIFY THE PROJECT

If Ania named the project, use it. Otherwise infer from content and confirm in one line.

Locate both sides:
- Local: `~/mnt/Work/<Project>/` via device_bash
- Notion: query Projects data source `collection://1f4cd6cc-cf0e-8113-8c1b-000b19ce189a` by name

If no project exists, stop and say so — this is a `work-intake` job, not an update.

**iCloud gotcha:** existing files in this tree are often cloud-evicted — `cat` returns `Resource deadlock avoided`. Stage the file instead of fighting the error. Files you write are fine.

---

## STEP 2 — CLASSIFY

Sort every piece of the incoming material into exactly one destination. Most drops contain two or three different kinds of information at once — split them.

| Kind of information | Goes to |
|---|---|
| Scope change, new constraint, new stack decision, new data source | `CLAUDE.md` — surgical edit to the relevant section |
| A choice that was made, and why | `decisions.md` — appended entry |
| A dataset, file, table, or export now in play | `sources.md` — registry entry |
| New source material (follow-up email, spec, meeting notes) | `intake/YYYY-MM-DD-<slug>.md` — verbatim |
| New work to do, or work now done | Notion Tasks |
| Status, deadline, or priority change | Notion Project properties |
| Something Ania explicitly asks you to remember | `MEMORY.md` — **only** on explicit ask |
| Chatter, ephemera, something already recorded | Nowhere — say so and move on |

The last row matters. Not everything needs filing. Recording noise is worse than recording nothing, because it buries the signal.

---

## STEP 3 — CHECK BEFORE YOU WRITE

Two things to catch before anything is recorded:

**Contradictions.** If the new information conflicts with what's already in `CLAUDE.md`, `decisions.md`, or the Notion page — don't silently overwrite. Show both versions and ask which wins. A stakeholder who changed their mind and a stakeholder who was misunderstood the first time need different handling.

**Scope creep.** If a follow-up quietly expands the ask, name it out loud before recording it. Give the effort delta (S/M/L/XL) and say whether it warrants a conversation with the requester. "They added a second cell line" can be an afternoon or a fortnight; say which.

---

## STEP 4 — SHOW THE ROUTING PLAN

One compact block, before writing anything:

```
→ CLAUDE.md §Technical Context: add <one line>
→ decisions.md: log <decision>
→ sources.md: register <dataset>
→ Notion: 2 new tasks, deadline → Oct 3
→ not filing: <thing>, already covered in <where>
```

One gate, batched. She says go, you write everything at once. Don't confirm each destination separately.

If the drop is trivial and unambiguous — a single new task, a status flip — skip the gate and just do it. Judgment call; err toward the gate when anything touches `CLAUDE.md`.

---

## STEP 5 — WRITE

### CLAUDE.md — surgical only

Edit the specific section. Never regenerate the file. Never touch the `## MEMORY SYSTEM` block. If a section doesn't exist yet, add it in the conventional position rather than appending to the bottom.

### decisions.md

Create on first use. Newest entries at the top under the header.

```markdown
# Decisions

## YYYY-MM-DD — <decision in one line>
**Who:** <who decided / who asked>
**Why:** <the reasoning, in one or two lines>
**Consequence:** <what this changes about the work>
**Source:** <email from X / Tuesday sync / Ania's call>
```

A decision without a *why* is worthless in six weeks — it just looks arbitrary and gets re-litigated. If the why wasn't stated, write `Why: not stated` rather than inventing one.

### sources.md

Create on first use. A registry, not a copy — never move large data files into the project folder.

```markdown
# Data Sources

## <name>
- **Location:** <BQ table / path / URL>
- **Pulled:** YYYY-MM-DD (or: live query)
- **Provided by:** <who>
- **Shape:** <rows × cols, or grain>
- **Gotchas:** <NAs, column naming, version drift, known bad rows>
```

The gotchas field is the whole point. Every hour lost to a data surprise should end with a line here.

### intake/

Raw source text verbatim, then a two-line summary of what changed. Provenance beats paraphrase.

### Notion

**Tasks** — `collection://1f4cd6cc-cf0e-81c4-9788-000b8095c344`
`Task` (title), `Status` (`Not started` / `Waiting` if blocked on someone else / `Done`), `Type` (`Task`), `Priority`, `Projects` (relation → the project), `Date Added` (today), `Due Date` only if real.

**Project** — `collection://1f4cd6cc-cf0e-8113-8c1b-000b19ce189a`
Update `Status`, `Deadline`, `Area`, `Tags` as warranted. Tags from existing options only — never invent one. Append a dated line to the page body for material changes; don't rewrite the body.

---

## STEP 6 — REPORT

What was filed where, in four lines or fewer. Then the single next action, if the update created one. Nothing else — she was there for the conversation.

---

## DEBRIEF MODE

If Ania says "debrief", "what changed today", "log this session", or is clearly wrapping up: sweep the whole conversation rather than one pasted item. Pull out every decision, constraint, result, and new task that surfaced, run them through the same classify → check → plan → write flow, and present one batched routing plan.

Be selective. A debrief that files twelve entries is a debrief that files nothing useful. Three good ones beat twelve.

---

## FILE / DATA MODE

If the new information is a file rather than text:
- Read it in place with device_bash — do not stage unless you need to *look* at it (image, PDF) or need a container-only tool
- Register it in `sources.md` with real shape and real gotchas, checked not assumed — row count, column names, NA rate on the columns that matter
- If it's small and project-specific, it can live in the project folder. If it's large or shared, register the path and leave it where it is.

---

## RULES

- Route, don't summarize. The output is files changed, not a recap.
- Never invent a *why*. "Not stated" is a real answer.
- Never auto-write to `MEMORY.md`. Explicit ask only — "remember this," "log this," "make a note." Flag contradictions there rather than overwriting.
- Never regenerate `CLAUDE.md`. Surgical edits only.
- Flag scope expansion out loud, with an effort delta, before recording it.
- One batched gate. Don't ask twice.