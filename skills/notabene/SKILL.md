---
name: nb
description: Auto-invoke when Ania sends a short aside that is clearly a "don't let me forget this" thought rather than a request — typically starting with "btw", "by the way", "oh, and", or similar, e.g. "btw need to reorder the kids' vitamins" or "by the way, ask the roofer about the flashing." Captures the thought verbatim as a timestamped bullet in her Notion daily log so it isn't lost, then confirms in one short line. Do NOT invoke this for a message that starts with "by the way" as a transition into a real question or task that needs actual work right now (e.g. "by the way, can you also fix the header bug") — only for genuine side-thoughts meant to be stashed for later. NOTE: invoke directly with `/nb <thought>`, or let it auto-trigger on natural language. It is deliberately NOT named "btw" because Claude Code has a separate built-in `/btw` slash command (ask a side question without interrupting current work). Never invoke this skill for a message starting with a literal "/btw" — that always belongs to the built-in command.
argument-hint: "<the thought to capture>"
---

# notabene (`/nb`, a.k.a. "btw") — quick thought capture

Purpose: zero-friction capture of a passing thought into Ania's Notion daily log, so she can immediately drop it and keep going. This is NOT a task to act on now — do not research it, do not turn it into a to-do, do not ask clarifying/categorization questions. Speed and low friction are the entire point.

## 1. Extract the note text

Strip a leading trigger phrase (case-insensitive) — "btw", "by the way", "oh and", "oh, and" — plus any immediately following punctuation (`,`, `:`, `—`, `-`) and whitespace. Keep everything after that verbatim as the note text.

- If invoked via `/btw <text>` or with `$ARGUMENTS`, the argument text *is* the note — no stripping needed.
- If the trigger phrase was sent with nothing after it, ask once: "What's the thought?" — do not guess or fabricate content.

## 2. Find the Notion tool

This session's Notion access is an MCP connector whose tools are typically named like `notion-fetch` / `notion-update-page` (possibly deferred — use ToolSearch with a query like `"notion-update-page"` if it's not already loaded).

If no Notion tool/connector is available in this session at all: tell Ania plainly that Notion isn't connected here and stop. Do not claim the note was saved if it wasn't.

## 3. Log it under today's heading on the "Brain Dump" page

Target: Ania's **Brain Dump** page, id `3decd6cc-cf0e-80c0-bc15-e0db119417a4`. This page holds a running log: one H1 per calendar day, with each day's notes as bullets under it. (There used to also be a separate "BTW" table on this page — Ania deleted it; the daily log is now the only destination. Don't recreate the table.)

1. Compute today's heading text with `date "+%A, %B %-d, %Y"` (weekday, month, day, year — e.g. `Thursday, September 17, 2026`). Never estimate or hardcode the date — always shell out for the live value. The Notion heading line is `# <that text>`.
2. Fetch the current content of the Brain Dump page (`notion-fetch` on its id/URL) and check whether a line exactly matching `# <today's heading text>` already exists.
3. **If today's heading exists already:** call the Notion page-update tool with `command: "update_content"` and `content_updates: [{"old_str": "# <today's heading text>", "new_str": "# <today's heading text>\n- <note text>"}]`. This inserts the new bullet as the first bullet under today's heading (newest-first for that day) — old_str must match the heading line exactly as it appears in the fetched content.
4. **If today's heading does not exist yet:** call the Notion page-update tool with `command: "insert_content"`, `position: {"type": "end"}`, `content: "\n# <today's heading text>\n- <note text>\n"`. This appends a new day-section at the end of the page.
5. Use the same verbatim note text from step 1 (no re-editing, no re-summarizing).

## 4. Confirm — briefly

Reply with exactly one short line, nothing else. No summary, no follow-up questions, no "would you like me to also...". Example:

> 📌 Logged.

If the tool call failed, say so in one line and show the actual error — don't retry silently more than once.
