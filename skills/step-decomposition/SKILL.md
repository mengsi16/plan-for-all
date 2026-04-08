---
name: step-decomposition
description: Use when a detail implementation plan needs execution-focused subplans that highlight the active objective, verification steps, exit criteria, and active blockers without copying the whole plan.
---

# Step Decomposition

Extract execution views from the detail plan.

This skill is not a copier. Its job is to preserve execution-critical information while removing planning noise.

Step decomposition also carries forward full-lifecycle audit state. If execution still depends on unresolved terminology, external claims, or recheck-required knowledge, the subplan must keep that visible.

## Purpose

A step subplan should help an executor answer these questions quickly:
- what is the current objective?
- which files are in scope?
- what must be proven before implementation?
- what is the next action?
- which knowledge blockers still constrain this phase?
- how do we know this phase is done?

If the subplan cannot answer those questions faster than the detail plan, it failed.

## Input

- detail plan path
- phase or workstream to extract
- UI constraints inherited from planning when applicable
- current audit blockers or recheck-required items from `task_plan.md` and `findings.md` when relevant

## Output

Write to:
- `docs/plan-for-all/plans/step_subplans/step_subplan_phase{N}.md`

Every generated subplan must start with a TDD guard banner that uses the skill name, not a file path:
- `> Required Skill: Invoke `plan-for-all:test-driven-development` before executing the detailed steps below.`

This stage runs after `writing-plans` and before execution.

## Extraction Rules

Keep these from the detail plan:
- phase title
- objective
- files in scope
- smoke check or failing-test target
- ordered execution steps
- verification commands
- exit criteria
- risks or blockers that matter right now
- knowledge blockers or recheck requirements that still affect execution

Compress or remove these when not execution-critical:
- repeated rationale already captured in the phase objective
- long examples and boilerplate
- broad context already present in the detail plan
- speculative implementation sketches

## Do Not Do These

- do not copy large code blocks by default
- do not preserve verbosity for its own sake
- do not invent implementation details that are absent from the plan
- do not change acceptance meaning
- do not hide verification behind vague wording
- do not drop unresolved audit items that still affect the active phase

## Recommended Subplan Structure

```markdown
# Phase N: [Name] — Step Subplan

> Source: `docs/plan-for-all/plans/YYYY-MM-DD-<topic>-detail.md`
> Required Skill: Invoke `plan-for-all:test-driven-development` before executing the detailed steps below.

**Objective:** [current phase objective]
**Mode:** [Greenfield | Bugfix | Refactor]

## Files In Scope
- Create:
- Modify:
- Test:

## Baseline Check
Run: `[command]`
Expected: `[current baseline or failure]`

## Knowledge Status
- Blockers:
- Recheck Required:
- Current Term Meanings To Respect:

## Execution Steps
1. [action]
2. [action]
3. [verification]

## Exit Criteria
- [observable condition]

## Current Risks / Notes
- [only if relevant]
```

## Extraction Heuristics

### For Greenfield Work
Highlight:
- the first observable behavior
- the smallest useful vertical slice
- the narrowest verification command
- any term or integration claim that the implementation must not silently reinterpret

### For Bugfix Work
Highlight:
- reproduction step
- failing regression test
- root-cause checkpoint
- minimal fix boundary
- any recheck-required knowledge if the bug may involve changed external behavior

### For Refactor Work
Highlight:
- preservation checks
- safety boundary
- incremental migration steps
- any external assumptions that must remain true during migration

## Audit Carry-Forward Rules

If a phase still depends on external knowledge, the subplan must show one of these states explicitly:
- `verified_official`
- `verified_recent`
- `unresolved`
- `stale_recheck_required`

If the detail plan says a term or external claim is unresolved, the subplan must not phrase the step as if that uncertainty disappeared.

If execution introduces a new suspicious term later, repair the plan and findings rather than quietly editing the subplan in isolation.

## Self-Check

Before saving the subplan, verify:
- the subplan starts with the required `plan-for-all:test-driven-development` skill banner
- the objective is obvious in under 10 seconds
- the verification step is visible without scrolling through implementation detail
- nothing essential was lost
- verbosity is lower than the detail plan
- active knowledge blockers are still visible when relevant
- the subplan is suitable for a fresh execution session
