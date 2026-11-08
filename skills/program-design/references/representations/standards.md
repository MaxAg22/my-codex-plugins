# Standards

The conventions that govern the implementation of the change, and what each one governs in it.

## What it covers

Every source of conventions the settled branches touch: the wiki entries for the technologies involved, the project's `AGENTS.md` and any other rule file it keeps. Each source is listed with the piece of the change it constrains. A source the change does not touch is not listed.

## What to check before proposing

- Derive the list from the settled branches.
- Read each source named before writing its line.

## Representation

One line per source, named by its path or wiki entry, followed by what it governs in this change, stated in terms of the settled branches: the declaration, the refactor, the emission, the gate. A reader can go from a source to the piece of the change it constrains and back.

```
- wiki `<topic>/<entry>`: the payload validation at the endpoint
- `AGENTS.md`, "Testing": where the new tests live and how they are named
- `AGENTS.md`, "Error responses": the error format the new endpoint returns
```

## When it fits

Once, always, after every other branch. The tree closes only when this list exists. Mark the list settled as soon as it is written; do not ask the user to confirm it.
