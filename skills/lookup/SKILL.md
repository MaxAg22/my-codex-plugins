---
name: lookup
description: Loaded by other skills that need a fact from the project's code, its docs or the outside world while working with the user. Carries the routing between the scouts and the researcher, the rule for facts outside the project, and how a verified fact is told apart from an asserted one.
---

# Lookup

Answers a question about the project's code, its docs or the outside world by routing it to the scout that reads that source, and reports what came back as verified or asserted. Investigate only what the question needs. Do not widen the search to things the user has not asked about yet, even when you can see they will matter.

## Routes

- `code-scout` custom agent for where something is implemented, which parts are involved, or how the code behaves. Give it the project's absolute path and the question.
- `docs-scout` custom agent for how something is meant to work, why a decision was made, or what a note commits someone to. Give it the project's docs folder, resolved as the $docs skill says, and the question.
- Both together, in parallel, when the question has a code side and a documentation side, whichever way the question is phrased. Discrepancies between their reports are findings in themselves. State both sides rather than resolving silently.
- Neither, when the question is about a library, a tool or anything else outside the project's own code and docs. The scouts read nothing there. Send an external fact to the `researcher` custom agent, or settle it by a direct trial: install the thing somewhere disposable, run it against the real input, read what it returns. A trial's result is a verified fact; a subagent's summary of documentation is not, and the answer says which of the two it used.

Spawn the required custom agents in parallel when the question has independent code, documentation, or research routes. Read a file directly only when the user points at it, or when an earlier answer in the same session already located it. A `grep` you run yourself over the project's tree is not a substitute for a scout. It puts the whole search into this conversation and misses the other places the question touches.

## Reporting

Keep verified facts apart from what a source asserts. When a fact contradicts a decision the user already made, or a claim they brought, say so plainly in the first sentence instead of working around it. Use a diagram when it helps explain the answer.
