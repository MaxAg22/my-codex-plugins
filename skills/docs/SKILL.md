---
name: docs
description: Loaded by skills and agents that read or write the project's own documentation. Carries how to find the docs folder, what its structure is made of, and the rule that the project's charter wins over anything a skill assumes.
---

# The project's docs

This skill set does not provide a shared knowledge base about a project. The project keeps one itself, in a folder it owns, usually `docs/`. Skills bring the process for writing into it; the project decides the structure. A skill that contains a string which would be wrong in a different repository is a bug. That is why no skill carries a template body.

## Finding the folder

In this order:

1. A section in the project's `AGENTS.md` pointing at one. Any section naming a documentation folder counts.
2. A `docs/` directory holding a `README.md`.

When none of these exists, say the project's docs are not set up and ask the user how they want the documentation organized. Never create the folder as a side effect of another skill.

The invariants note is `invariants.md` at the docs folder's root, or the file the charter names for it. When neither exists, tell the user once that the project keeps no invariants, and continue.

## What the structure is made of

These are the parts you may assume exist. What each one is called, contains or looks like is the project's, and you read it rather than assume it.

- **The charter** is the `README.md` at the folder's root. It says what each folder holds, how files are named, what frontmatter they carry, how a note is written, and how the indexes work.
- **The invariants note**, when the project has one, lists the rules every change respects, one sentence per rule. A rule links to the note that explains it, if that note exists.
- **Each folder's index** is its own `README.md`. It is either a hand-kept table, where a note joins by getting a row, or generated (an Obsidian base querying a tag), where a note joins by existing with the right tag and a wrong tag drops it out silently.
- **Templates**, when the project has them, live where the charter says, usually `_templates/`. A note is created from the template for its kind; when there is none, from the closest existing note in that folder, and you say which.
- **Notes explain how a part is**, in the present tense. Some projects also keep **records** (a quest log, a decision register) that say what was tried or intended; the charter says which folders hold which, and the note-writing rules do not govern records.

## How a note is shaped

The project's note template decides the note's sections, order, diagrams, callouts, and formatting. Read it when present. When there is no template, follow the closest existing note and tell the user which one you used. Do not impose a template of your own.

## The rule

Read the charter and the target folder's README before writing or judging a line. Where the project differs from anything a skill or an agent sketches as an example, the project is right. If the charter and `AGENTS.md` disagree, the charter is right, and you fix both.
