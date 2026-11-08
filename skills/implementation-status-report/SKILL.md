---
name: implementation-status-report
description: Reports where an implement or implement-with-tdd run stands, from the change's implementation-status.md. Gives a short update against the previous report, the highlights since then, and every open item with the context to settle it. Use during either run and at its end, where implement loads it for the final report.
---

Load $basics first, then $report.

# Implementation status report

`implement` keeps `implementation-status.md` in the change's scratch folder current while subagents work. This skill prompts, spawns and closes no subagent, and writes no file.

## What it reads

`implementation-status.md`, then the conversation, for the last status report given in it, if there is one.

## The report

Start with the blocking questions: each question a subagent is waiting on, with the subagent's label, what it asked and why it cannot continue without the answer.

Then a section for the project:

1. **Status.** One or two lines: the stage the project is in, the subagent or check running on it, and the latest test results. With no earlier report in the conversation, give the project full status.
2. **Highlights.** What happened in the project since the last report that the status does not show: a departure from the design, a fact that changed a plan, a crash and the work it lost.
3. **Open items.** Every item in the project that waits on the user, numbered across the whole report. Give each item the context to decide without asking back: why the item exists (why the reviewer proposed the change, why the subagent raised the flag), what the code does today, why it was skipped or held, and the changes each answer would require. An item the user already settled in the conversation does not appear.

Keep the highlights short.
