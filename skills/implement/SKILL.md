---
name: implement
description: "Implements a change whose design and test design are settled, by delegating the work to a subagent with the full context: the tasks, the design notes, the test matrix, the project rules and the report shape. Collects the results, then coordinates manual validation against the local system, fixes failures against previous decisions until every row passes, runs the round-based agentic review, and reconciles the design. Use after test-design, before human-review."
---

Load $basics first. Then read `.mahou/implement.md` if present: it is where a project names its task tracker, the tool that reaches it and the states a task moves through. Follow the wiki indexes only far enough to know which entries exist; the subagents read the entries for the code they touch.

# Implement

Takes a change the user has designed and test-designed and gets it written by a subagent that receives everything a person joining the work would need. It composes the brief, dispatches the subagent, relays what comes back, and coordinates the passes that follow the code: manual validation, which fixes what fails against previous decisions; agentic review; and the consistency check.

## Opening

1. **Collect the inputs.** The tasks when the project tracks them, the design notes, the test-design trees with their matrices, the branch name, and the subagent model and effort the user wants. Ask for whatever is missing in one round; do not start a subagent without the test matrix.

## The brief

The subagent gets a brief with all the context it needs. Nothing in it is optional, and the brief leaves the subagent nothing to look up.

- **The change.** The design notes by path or URL, and a design summary in the brief itself: what changes, the shapes that cross systems, the rules the design settled, what is out of scope. Tell it to read the notes before touching code, with the reasoning effort the user named.
- **The tasks.** The ones each with what it requires in one or two sentences and the order to work them in. Without a tracker, the list comes from the test-design trees and the user.
- **The tests.** The matrix rows, verbatim, with each row's `★` mark, expected outcome and kind, plus any `Deleted:` lines under each branch, read from the change's scratch folder at `test-design.md`. On `test` rows (including `test + manual`), a `★` row is a new test the subagent writes, at the level the project's conventions name and named after what the test proves; an unstarred row whose expected outcome is the one the suite already checks is a regression row, left untouched and still passing; an unstarred row whose expected outcome changed is updated to match it; a test listed under `Deleted:` is removed from the suite. The rows carry ids for the matrix only: no row id, tracker id, or scratch path appears in a test name, comment, or docstring; the mapping stays in the scratch folder and out of the project. The `manual` rows are for later; the subagent does not run them.
- **Project rules.** Follow the project's `AGENTS.md` and `.mahou/basics.md` when present, the wiki entries for the technologies it touches, and the user's own coding style file. Where a wiki entry defines a component or library for what you are building, use it instead of writing a custom equivalent; on frontend screens, start from the wiki's frontend entries. The prototype settles how the change looks and behaves, and the program design settles what each part does, where it lives and what crosses between parts. Neither settles how a line is written. A representation shortens the code so it reads at a glance, such as a ledger line that reads a field straight off a hook's result. The prototype's code exists only to show the screen. Write the code the wiki entries, the project's rules and the user's style file ask for. When following one of them changes what a part does, where it lives or its interface, raise it as a departure instead of deciding it. Keep changes minimal and consistent with the surrounding code. Run linters and the full relevant test suites; everything must pass.
- **Tracker states**, only when the project tracks tasks: move each task to the tracker's in-progress state when it starts it and to its done state when its change is implemented and tested, using the tool and the state names the project declares. The list stays current: work the tracker does not register becomes a new task, created and worked like the rest; a task that dissolves mid-work is closed with a line saying why. Each is named in the report. The tracker can be anything (Linear, Jira, Notion, GitHub issues, a beads database) and the brief names it concretely.
- **How to answer.** A report in the shape $report gives: the branch, a summary of the change, the row-to-test mapping, the linter and test output tail, and what it could not resolve. The report is the whole of the subagent's final message, because the session that collects the result reads only that message. A shorter message sent after the report replaces it. Every later instruction to the subagent repeats this. A design ambiguity that changes the outcome is a question back through the subagent's question channel, not a guess. The subagent applies a fix the user decided exactly as the user decided it. When the subagent thinks another fix fits better, it asks through the same channel instead of applying its own.

## Dispatch and collect

Use Codex subagent delegation to start one implementation subagent for the project. Give it one task covering the project. Wait for its result without polling. Do not relay results to the user as they land. Record the result in `implementation-status.md` (below), then dispatch the next subagent when the procedure calls for one. Every decision you record, whether a flag, a question or a departure from the design, carries enough context for the user to decide without asking back. Start with why the subagent raises the decision. Answer the subagent's questions with the user's decisions and no others. Close the subagent once its result is collected and nothing remains to ask it.

When a subagent cannot continue without an answer, send the subagent's question to the user as soon as the question arrives, with that same context. Repeat it at the top of every later reply until the user answers it.

The user asks for the state with $implementation-status-report.

### implementation-status.md

Keep `implementation-status.md` in the change's scratch folder for the run. Create it when the first subagent starts and give it its line in `status.md`. Update it in place rather than appending to it:

- **Blocking questions.** Each question a subagent is waiting on, until the user answers it.
- **Project status.**
  - **Status.** The branch and stage (implementing, validating, fixing blocked rows, validated, reviewing round n, reviewed, reconciling), the checks' last result, and the subagent or check running on the project. Rewrite it when any of these changes.
  - **Highlights.** One line per event that the status does not show and a later report must mention, such as a departure from the design or a fact that changed a plan. Remove a line once a report has carried it and the event no longer bears on anything open.
  - **Open items.** Every decision waiting on the user, each with the full context the report needs. Remove an item when the user settles it, and record the settlement where `basics` says decisions live.

The subagent kept for further work, such as the manual validation, a fix or the review, carries earlier tasks in its context. Check its context use whenever it finishes a task. When its context use nears half, have the subagent run `/compact` with a list of what to keep, such as the project state, the safety rules and where the brief lives, then send the next task. Compact only between tasks, never while the subagent is working on one.

When the user steers mid-run, forward the steering to every subagent it concerns as a supervisor directive; a subagent that is mid-turn picks the directive up when it finishes the turn.

## Manual validation

Validation runs before the review, so the review runs once over the code that passes validation instead of after every batch of fixes.

After implementation and automated tests pass, the subagent runs the manual rows against the local system. It uses the expected outcomes and setup from the matrix, plus the identities and inputs the user provides. It loads $validate, runs the rows through it, and produces the report artifact `validate` requires. It brings up everything the rows need without asking, and stops to ask only when a credential is missing or a service fails to come up. It captures and restores every record it creates or mutates.

### Fixing without asking

The subagent fixes a failing row without asking, inside the bounds $validate gives, and re-runs the rows until every row passes or is blocked. The subagent reports the rows with their results, each fix with what failed and what it changed, each blocked row, and each bug it left unfixed. A bug the run finds that no row and no previous decision covers is reported, not fixed.

Record the fixes in the project status, each blocked row as a blocking question with the evidence and what each way out changes in the designed behaviour, and each unfixed bug as an open item. Continue any unblocked validation rows while waiting for the user's answers.

### Fixing what the user decides

Once the user settles a blocked row, the subagent applies the decision exactly as the user decided it and re-runs the affected rows, plus any row the fix's code reaches. A re-run waits for the system like any other run. Repeat until every row passes; the project stage is then validated.

## Agentic review

When validation is complete, the subagent invokes $agentic-review on the project diff. The review runs in rounds, each with fresh reviewers and the ledger of the earlier rounds' fixes and skips, so a fix is not undone in a later round. It fixes inside its own bounds and leaves the edits in the working tree. The review does not change behaviour, so validation does not run again after it.

The review ledger is the round status the user reads mid-run; point to it from the project status.

Then record every skipped finding as an open item of the project: apply it or leave it. Give each finding with enough context to rule on it without asking back: the problem the reviewer saw and why the reviewer proposed the change, then why the review skipped the finding. A finding the user decides to apply is applied by the implementation subagent; it gets no further review round, since $human-review reads it next. Record each finding the user leaves as skipped in the change's scratch folder.

## Design reconciliation

The code that lands is what was actually built, and the notes drift from it the moment a child deviates, simplifies, or meets a platform fact. When the review has ended and its skipped findings are settled, collect the drift: every flag a subagent raised about a design mismatch, every pointing callout in a touched note whose condition has now landed, and every diagram that renders a shape the change altered. Then dispatch `consistency-checker` with a summary of what the change replaced. It finds the leftovers and disagreements that no flag named. The user settles each item. The implementation subagent applies the agreed code fixes and re-runs the manual rows those fixes reach; the fixes get no review round, since $human-review reads them next. The agreed documentation updates run through $write-documentation once, with the whole documentation in view.

## Ending

When the subagent is done, give the final report through $implementation-status-report, including the manual rows and results, any validation fixes, the report artifact path and review ledger path. $human-review follows when the user asks for it.

## What this skill is not

It does not write code, does not design tests, does not decide a design ambiguity on the subagents' behalf, and does not publish the change.
