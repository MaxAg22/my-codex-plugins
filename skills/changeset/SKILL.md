---
name: changeset
description: Loaded by other skills to establish which project change is in scope, the base it is measured against, and the diff composed from it.
---

# Changeset

Defines the change once, so every skill that reasons about it agrees on what is in scope. A skill that reviews, traces, or reports on a change loads this first.

## Address the project by path

Use the absolute path of the project's Git working tree. Use `git -C <project-path>` for every Git command and absolute paths for every read.

**Never `cd`.** A foreground `cd` persists across Bash calls, so a later call, especially one of several sent in the same message, can run in the wrong project and return output under the wrong name.

## Establish the base

The base is the commit you measure the change against. Report it; never assume it silently.

Run the bundled script from this skill's directory, passing the absolute project path:

```bash
bash <changeset-skill-path>/scripts/find-base-branch.sh <project-path>
```

The script fetches from `origin` and returns JSON with the remote branch that the current branch has the fewest commits ahead of. It skips the branch's own remote copy. Use its `base_branch` as `origin/<base_branch>`. Do not take the base from `origin/HEAD`, because it can point at a trunk the work did not branch from. If the script errors or returns a branch you cannot account for, ask. **Never guess between `main` and `master`** by checking which exists; a project can carry both. Do not fall back to `HEAD~1`.

Report the base you used so findings about the same work can be compared.

## Compose the diff

A changeset is composed from these parts, and you decide which are in scope rather than taking a default:

| Part | Command |
|---|---|
| Changes on the branch | `git -C <project-path> diff <base>...HEAD` |
| Uncommitted | `git -C <project-path> diff HEAD` |
| Untracked | `git -C <project-path> status --porcelain` |

Use the three-dot form for the branch changes. It shows what the branch added since it diverged and excludes anything that landed on the base meanwhile. Two-dot mixes the two and attributes other people's commits to this change.

Stashed work is not part of the changeset. Neither is work on another branch. Include either only when the user says to, and say in the report that you did.

State the composition you used in one line before presenting anything derived from it, so a wrong scope shows up instead of passing unnoticed.

## Separate introduced from pre-existing

A line inside the diff is not necessarily a change the diff made. Before calling anything introduced, read the base version:

```bash
git -C <project-path> show <base>:<path>
```

Compare the behavior, not the text. Code can move, be re-indented, or be extracted without changing what it does, and a symbol can sit untouched while its callers change what they pass it. `git log` and `git show <commit>` settle which commit introduced a line when the base comparison is not enough.

Every claim that something is new, changed, or broken carries this distinction: introduced here, pre-existing, or pre-existing and widened by this change.
