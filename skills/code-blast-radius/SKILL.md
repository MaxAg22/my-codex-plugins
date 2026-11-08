---
name: code-blast-radius
description: Traces what an already-written change reaches. Fans out a tracer per changed element and reports only the places where behavior changes for someone. Use after code is written, before it is reviewed or merged.
---

Load $basics first. Then read `.mahou/code-blast-radius.md` if present.

# Code blast radius

Answers one question about a change that already exists: what else does it touch, and does any of it break. This is not a review. It says nothing about whether the change is good and does not hunt for bugs inside the diff.

## Step 0: Load what the tracing needs

Load $changeset for the project, the base, and the diff. Read the project's `AGENTS.md` when present, and its README or other available layout documentation, so you know which layers a change can travel through.

## Step 1: Inventory the changed elements

List every element the change alters that something else can depend on:

- function and method signatures, including defaults and the types behind them
- return types, raised exceptions, and error codes
- endpoint paths, request payloads, response shapes, status codes
- exported types and shared components
- database models and columns
- test factories and fixtures, which reach every test in the suite

Skip anything nothing can depend on. A renamed local has no users.

## Step 2: Trace each element

Spawn one `usage-tracer` custom agent per changed element through Codex. Give each the element, the project's absolute path, and the base; spawn them together so they run in parallel.

Use the configured `usage-tracer` agent type for each subagent. Collect the findings files they write rather than relying on long inline reports.

## Step 3: Merge what comes back

Tracer findings arrive unverified. Drop any that fails to name a consumer and what that consumer does differently. Check the rest against the code yourself before they reach the report.

Collapse findings that different tracers raised about the same consumer, and keep the attribution each tracer gave: introduced by this change, pre-existing, or pre-existing and made reachable more often by this change. A pre-existing problem goes in the report only in the third case.

## Step 4: Report

State the base and the diff composition in one line. Then the findings, ordered by reach, with the ones outside the change's own feature first.

Give each one its file and line, what changes for whom, and its attribution. Do not list everything the change touched, and do not pad the report with the consumers you cleared.

When nothing changes for anyone, say so in one line.
