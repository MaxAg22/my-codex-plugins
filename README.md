# My Skills

A collection of skills and specialist agents for understanding, designing, implementing, and reviewing software changes.

## Philosophy

- The user makes decisions; the agent brings evidence, options, and work for the user to review.
- Each skill has one clear job. Skills can call supporting skills when their procedure needs them.
- Process belongs in skills, technology knowledge belongs in the project's wiki, and the project's own system documentation belongs in its docs.
- Preserve settled decisions across stages. When an implementation would change one, bring the question back to the user.

## How to use it

Describe your goal in plain language to `$guide` if you are unsure which skill fits. If you know the skill, invoke it as `$skill-name`. A stage skill can use its supporting skills and agents as described in its instructions.

## Skills

### Workflow skills

- `explore`: Investigate a problem through user-led questions. Starts from the context the user provides, answers questions with evidence gathered through scouts, and records settled decisions and findings in the change's scratch folder when exploration ends.
- `shape`: Settle what a solution must do and what is out of scope by resolving the open decisions in a design tree. It covers behavior and decisions, not implementation.
- `design`: Define the system-level design for a settled problem, one area at a time, then hand the settled design to `write-documentation` when documentation is needed.
- `program-design`: Turn a settled design or user-confirmed change into a code-level plan covering the affected parts, their interfaces, call paths, files, and conventions.
- `test-design`: Define test cases and manual validations before implementation, using classification trees and a combination matrix.
- `implement`: Coordinate implementation from the settled design and test matrix. It includes automated checks, manual validation, agentic review, consistency reconciliation, and a final status report.
- `implement-with-tdd`: Run implementation test-first with a tester and implementer, then continue with `implement`'s manual validation.
- `validate`: Run the manual validations against the local system, capture evidence, restore records changed during the run, and report results.
- `agentic-review`: Review a change for reuse, simplification, efficiency, abstraction level, and project conventions; apply in-scope improvements over up to three rounds.
- `code-blast-radius`: Trace where a written change's behavior reaches its consumers within the project.
- `human-review`: Check observations the user makes about a change against the code, discuss the assessment, and wait for the user's decision before editing.
- `write-documentation`: Write or update a note in the project's documentation, following its charter and templates.

### Supporting skills and tools

- `guide`: Route a goal stated in plain language to a suitable skill.
- `lookup`: Route fact-finding to code scouts, documentation scouts, or external research, and distinguish verified facts from source claims.
- `spike`: Run a small experiment when reading code or documentation cannot answer a question.
- `prototype`: Build and iterate on an interactive screen prototype.
- `architecture-exploration`: Explore system parts and architecture options with the user on a canvas.
- `canvas`: Draw and edit diagrams, mockups, and other visual work on a local tldraw canvas.
- `fast-track`: Apply its faster question and confirmation rules when used with supported canvas stages.
- `agent-browser`: Browser automation used by browser-based validation and canvas tooling.
- `wiki`: Read the project's technology knowledge and conventions through its index.
- `report`: Provide the response shape used by implementation reports.
- `implementation-status-report`: Summarize the current state, questions, results, and open items from an implementation run.

Canvas variants run the corresponding stage visually: `explore-with-canvas`, `shape-with-canvas`, `design-with-canvas`, `program-design-with-canvas`, and `test-design-with-canvas`.

Skills loaded by other skills: `basics`, `docs`, `design-tree`, and `changeset` provide shared rules or formats used by the workflow.

## Agents

`agents/` contains specialist role definitions in Codex TOML format. When installed, they live in `.codex/agents/` and skills dispatch them to investigate or review a bounded question. They return findings to the skill coordinating the work. Their instructions define each role; Codex agents inherit the parent session's tools and permission settings.

- `code-scout`: Investigate one question in the project's code.
- `docs-scout`: Investigate one question in the project's documentation.
- `researcher`: Find and report facts about an external library, tool, or platform.
- `documentation-reviewer`: Review a documentation draft against the project's charter and template.
- `reuse-reviewer`: Find existing project code that could be reused.
- `simplification-reviewer`: Find unnecessary complexity or duplication.
- `efficiency-reviewer`: Find avoidable work or resource use.
- `altitude-reviewer`: Find mechanisms that should be generalized instead of layered with special cases.
- `conventions-reviewer`: Check a change against one project convention source.
- `usage-tracer`: Trace consumers of one changed element.
- `consistency-checker`: Find implementation leftovers and mismatches between the code and project documentation.

## Workflow

The stages describe the usual path through a change:

| Stage | Skill | Purpose |
|---|---|---|
| 1 | `explore` | Understand the problem and investigate what is needed. |
| 2 | `shape` | Agree on the behavior and scope of the solution. |
| 3 | `design` | Define the system's data, flows, rules, and components. |
| 4 | `program-design` | Specify the code parts, interfaces, call paths, and files involved. |
| 5 | `test-design` | Define the tests and validations that will demonstrate the change works. |
| 6 | `implement` | Implement the change, including its validation and review procedure. |
| 7 | `validate` | Check the behavior in the running system. |
| 8 | `agentic-review` | Review and improve the code within the settled decisions. |
| 9 | `code-blast-radius` and `human-review` | Trace the change's impact and review it with the user. |
| 10 | `write-documentation` | Update the project documentation to reflect the change. |

Supporting skills help with specific questions or visual work as needed. The `with-canvas` variants use the corresponding stage's procedure on a canvas.

## Project knowledge and documentation

The project owns its wiki: its location, structure, index, and technology conventions. If a needed wiki or convention is undefined, the skill asks the user rather than inventing one.

The project also owns its documentation. `docs` explains how to find its documentation folder, read its charter, and follow the charter's rules. `write-documentation`, `explore`, and `design` use that guidance when their procedures require project documentation.

Projects can customize a skill with `.mahou/<skill>.md` and define standing project rules in `.mahou/basics.md`. Local rules take precedence when they conflict with shared skill instructions. The project's `.scratch/<change-slug>/` folder holds artifacts that need to persist between stages, such as design handoffs, prototypes, and drafts.

## Using with Codex

From the root of the project where you want to use the skills and agents, run:

```sh
curl -fsSL https://raw.githubusercontent.com/MaxAg22/my-codex-plugins/main/install.sh | bash
```

The installer downloads the repository into a temporary directory, checks for existing skill or agent names, and stops without copying if it finds a conflict. Otherwise, it creates `.agents/skills/` and `.codex/agents/` if needed and copies the files there. The temporary download is removed when the script exits. Preserve each skill's accompanying references, scripts, and assets.

### Canvas requirements

Text-based skills need no project-specific runtime dependencies. Canvas and browser workflows require:

- Node.js and npm. The canvas script installs its app dependencies into the local cache the first time it starts.
- The `agent-browser` CLI and its browser installation. Install them with `npm install --global agent-browser` and `agent-browser install`.

The canvas app starts locally for each document and saves the canvas file beside the scratch artifacts. Canvas use is optional; the corresponding chat-based skills do not require it.
