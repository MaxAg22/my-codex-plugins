---
name: human-review
description: Reviews the user's observations about an implemented change, verifies each against the code, and waits for the user's decision before editing. Use when the user asks to review a change with them.
---

Load $basics first. Then read `.mahou/human-review.md` if present.

# Human review

Verifies the user's reading of a change and settles each observation with them. Nothing is edited until the user decides what to apply.

When both review skills run, $agentic-review goes first. It clears mechanical findings so this pass can focus on judgment.

## Step 1: Establish the changeset

Load $changeset. It defines the project, the base and the diff, and tells you whether an observation concerns something introduced by this change or something that predates it.

## Step 2: Collect the user's observations

Use the observations the user gives in the conversation about the changeset. If the user has not shared any, ask them to review the diff and describe the points they want checked. Do not create findings of your own; this pass verifies the user's reading.

## Step 3: Verify each observation

Read the flagged lines before responding. Establish whether the change introduced what is flagged or whether it predates the change, using the base from `changeset`. Give each observation a verdict: Confirmed, Partly, Not a bug, or Intended, with the lines that support it.

Present questions first, because an answer can change what should be applied. Then show the observations and their verdicts. A verdict is your assessment, not a decision. Do not edit anything yet. Ask which observations the user wants applied and wait for their decision.

## Step 4: Apply what the user decides

Before writing code, read the project's `AGENTS.md` and `.mahou/basics.md` when present, and read the wiki entries for the technologies the fix touches. Follow the project's conventions.

Apply only the fixes the user approved, following their decisions. Run the relevant linters and tests, scoped to the files you touched rather than the whole project. Avoid formatting unrelated files.

Report the observations applied, the files changed and the checks run. Leave the edits in the working tree.
