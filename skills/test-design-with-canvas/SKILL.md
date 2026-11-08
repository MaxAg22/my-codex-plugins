---
name: test-design-with-canvas
description: Runs the test-design skill on a canvas instead of in the chat. The candidate roots are drawn on a map of the system for the user to pick, and each branch is drawn as a classification tree with its combination matrix under it; the user corrects with sticky notes or by voice. Use when the user wants to design the test cases and manual validations of a settled change on a canvas.
---

Load $test-design first, then $canvas.

# Test design with canvas

`test-design` and the skills it loads keep their procedure: roots, branches, classifications, partitions, matrices, facts, dropped rows, recording and ending.

When the user asks for a fast track, or fast track is already on in the session, load $fast-track after $canvas and before starting, unless it is already in context. It changes some of this skill's engagement rules.

The document is `canvas/test-design.tldr.json` in the change's scratch folder. The record stays `test-design.md`; write the tree's changes into it whenever the canvas changes, and draw the canvas from it.

## Roots on a map of the system

The candidate roots go on the canvas as a map of the system, under a title naming the change.

- **The tree is an `area`**, labelled with the change it covers.
- **Each candidate root is a blue card** inside the tree's area. Its first line is an empty checkbox, `☐`, for the user to tick, then the root's id and its entry point; its second line is `e.g. <scenario>`, one or two scenarios through that entry point, an error case among them.
- **A candidate that is not a root is a grey dashed card** with the reason, such as a piece that runs only inside another entry point, or a migration, checked by one manual row.
- **Arrows join the cards that hand work to each other**, each labelled with the action one card asks of the other, such as `create` or `start`.

Tell the user to tick or cross out cards with sticky notes or by voice.

## Each branch is a classification tree

Each branch is an `area` labelled `<id> <root> · <status>`, inside the tree's area. Branches stack down the tree's area.

Draw every branch of the tree at once, each one whole: its root, classifications, partitions and matrix, labelled `proposed`. This replaces `test-design`'s one level and one branch at a time. A branch, and everything on it, stays `proposed` until the user approves it.

Draw each branch with `canvas`'s `classificationTree`, which lays out the root, the classifications, the partitions and the matrix. Keep each branch's spec as data in a script in the canvas folder. When a branch changes, such as a row turned manual or a partition added, call the helper again with the same name.

- **The root is a blue box** at the top, with the entry point and what it is given.
- **Each classification is a violet box** under the root, joined to it by a line with no arrowheads.
- **Each partition is a green box** under its classification, joined the same way, with a short label.
- **The matrix goes under the tree.** On the left, a narrow `★` column sits before `row · what the test does`, separated from it by a vertical dotted grey line; on the right, the header reads `expected · kind · setup`. Header labels are grey. Each row is one line: `★` in the first column when `isNew: true` and blank when the test already exists in the suite, its id and summary next to it, a filled dot under the centre of each partition it picks, and its expected outcome, kind and setup on the right. Dotted grey lines run between the rows and down each partition's column.
- **A row run by hand is orange**, its `★`, its text and its dots, whether it is `test + manual` or `manual`. Its expected outcome adds what the check observes by hand.
- **Dropped rows and deleted tests get grey lines under the matrix**, `Dropped: <reason>` and `Deleted: <test and reason>`. When either list is empty, nothing is drawn for it.
- **A branch with one row** draws its root and that row, with no classifications.

## Questions

A question goes inside the branch it is about, beside the classification, partition or row it discusses. A question about a root goes beside its card on the map. The branch's Agent note goes under the questions.

- **A question is a card with a violet border and no fill**, titled `❓ Q<n> · <title>`, then the body, which gives the situation and ends with the question. The card has no fill so it differs from the filled violet classification boxes.
- **Follow-ups stay inside the base question's card**, one at a time, until the question closes. The card holds, top to bottom: the base question, a summary box, one Agent note, and the current follow-up as a card of its own.
- **The summary box**, a solid grey rectangle labelled `Summary · Q<n> so far`, holds what the question has settled. Rewrite it each round; never add a line per answer.
- **When the question closes**, delete the card, redraw the branch with what it settled, and update the record.

## Messages from the agent

Everything you would say in the chat goes on the canvas, as an Agent note: a grey dashed rectangle labelled `Agent`, in the branch, tree or question it is about. One note at the top of the canvas says how to read the drawing and lists the implementation tasks the tree surfaced. Keep one Agent note per place and replace its text each round.
