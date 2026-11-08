---
name: guide
description: Routes a goal stated in plain language to the skill that fits it. Use when you are unsure which skill handles the task.
---

Load the $basics skill first.

Routes a goal to the skill that handles it. Performs no work of its own.

## Procedure

1. Restate the user's goal in one line, in your own words. If the restatement is wrong, the user corrects it now rather than after a skill has run.
2. Match the goal against the names and descriptions of the skills available to Codex. Skip shared instruction skills that are loaded by other skills rather than run directly (`basics`, `docs`, `design-tree`, `changeset`, `prototype`, `report`).
   - Exactly one fits. Say which one and why in one line, then invoke it by its Codex skill name (for example, `$explore`) with the original request as context.
   - Several could fit. List them with one line each and ask the user to choose. Never pick for them.
   - None fits. Say so plainly and stop.
3. Hand off. Do not do the work yourself, do not summarize what the skill is about to do, and do not run a second skill afterwards unless the user asks.

## The usual order

When the goal is a change rather than a single task, the skills describe a sequence: `explore`, `shape`, `design`, `program-design`, `test-design`, and `implement`. `implement` includes validation and agentic review. `code-blast-radius` and `human-review` can examine the result, and `write-documentation` records what was built. `spike`, `prototype`, and `architecture-exploration` help answer specific questions along the way. Say where in that sequence the goal sits when it helps the user pick, and route to that one skill only.
