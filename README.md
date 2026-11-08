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

### Workflow

The stages describe the usual path through a change:

1. `explore`: Investigate the problem through user-led questions and record settled decisions and findings.
   - `explore-with-canvas`: Work through the same exploration on a visual canvas.
2. `shape`: Settle what the solution must do and what is out of scope; this covers behavior, not implementation.
   - `shape-with-canvas`: Resolve the same behavior decisions on a visual canvas.
3. `design`: Define the system-level design for the settled problem, then hand it to `write-documentation` when needed.
   - `design-with-canvas`: Work through the same system design on a visual canvas.
4. `program-design`: Turn the settled design into a code-level plan covering affected parts, interfaces, call paths, files, and conventions.
   - `program-design-with-canvas`: Work through the same code-level plan on a visual canvas.
5. `test-design`: Define test cases and manual validations before implementation, using classification trees and a combination matrix.
   - `test-design-with-canvas`: Work through the same test design on a visual canvas.
6. `implement`: Coordinate implementation from the settled design and test matrix, including checks, validation, review, reconciliation, and a status report.
   - `implement-with-tdd`: Use a test-first implementation procedure, then continue with `implement`'s manual validation.
7. `validate`: Run manual validations against the local system, capture evidence, restore changed records, and report results.
8. `agentic-review`: Review for reuse, simplification, efficiency, abstraction level, and project conventions; apply in-scope improvements.
9. `code-blast-radius` and `human-review`: Trace the change's impact, then assess the user's observations against the code before editing.
10. `write-documentation`: Update project documentation according to its charter and templates.

### Other skills used by the workflow

- `guide`: Route a goal stated in plain language to a suitable skill.
- `lookup`: Route fact-finding to code scouts, documentation scouts, or external research.
- `spike`: Run a small experiment when code and documentation cannot answer a question.
- `prototype`: Build and iterate on an interactive screen prototype.
- `architecture-exploration`: Explore system parts and architecture options with the user on a canvas.
- `canvas`: Draw and edit diagrams, mockups, and other visual work on a local tldraw canvas.
- `fast-track`: Use faster question and confirmation rules with supported canvas stages.
- `agent-browser`: Provide browser automation for browser-based validation and canvas tooling.
- `wiki`: Read the project's technology knowledge and conventions through its index.
- `report`: Provide the response shape used by implementation reports.
- `implementation-status-report`: Summarize state, questions, results, and open items during implementation.

`basics`, `docs`, `design-tree`, and `changeset` are shared instruction and format skills loaded by other skills.

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

## Project knowledge and documentation

The project owns its wiki: its location, structure, index, and technology conventions. If a needed wiki or convention is undefined, the skill asks the user rather than inventing one.

The project also owns its documentation. `docs` explains how to find its documentation folder, read its charter, and follow the charter's rules. `write-documentation`, `explore`, and `design` use that guidance when their procedures require project documentation.

The project's `.scratch/<change-slug>/` folder holds artifacts that need to persist between stages, such as design handoffs, prototypes, and drafts.

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
