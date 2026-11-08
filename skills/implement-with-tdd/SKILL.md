---
name: implement-with-tdd
description: "Implements a designed and test-designed change test first. A tester writes and validates the tests while an implementer writes the code; the session relays feedback between them. Use when the code should be written test first."
---

Load $basics first, then $implement. Then read `.mahou/implement-with-tdd.md` if present.

# Implement with TDD

Follow `implement` from start to end. Only how the project's code gets written changes, in `implement`'s Dispatch and collect. The opening, the brief, manual validation, agentic review, design reconciliation and ending stay as `implement` states them.

## Two subagents

Use Codex subagent delegation to start two independent subagents: one with a tester prompt and one with an implementer prompt. Both get the project's full brief from `implement` and work in the same project. Neither spawns the other. Every exchange passes through the main agent, which relays feedback and records it in the project's section of `implementation-status.md`.

## The rounds

1. **Red.** The tester writes the new tests for the project's `★` `test` rows, updates any unstarred `test` rows whose expected outcome changed, and removes any tests listed under `Deleted:`. It leaves the unstarred rows whose expected outcome did not change untouched, because they are regression rows. It runs the suite and confirms that each new or updated test fails because the behaviour is missing, not because the test is broken, and that every regression row still passes. When the tests cannot load before the code exists, it says how it checked the reason for the failure. It reports the row-to-test mapping, the files it changed and why each test fails.
2. **Green.** Relay the failing tests and the changed files to the implementer. It writes the code until the tests pass, then reports the linter and test output tail.
3. **Validate.** Relay the implementer's report to the tester. The tester runs the suite, confirms the regression rows still pass, and checks the code against the design's rules and contracts, not only against the tests. It answers with an approval or with concrete feedback. Relay the feedback to the implementer and repeat 2 and 3 until the tester approves.

Rules for the rounds:

- The implementer does not edit test files. When it believes a test is wrong, it says so, and this session relays the claim to the tester.
- The tester does not edit the implementation.
- When either subagent finds a design ambiguity that changes the outcome, this session asks the user. Neither subagent decides it.

Once the tester approves, continue with `implement`'s manual validation for the project.
