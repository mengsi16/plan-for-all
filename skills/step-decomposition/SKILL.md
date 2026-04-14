---
name: step-decomposition
description: "Use when a detail implementation plan needs to be split into completely separated subplans for execution. The subplan must be a full, verbatim copy of the phase from the detail plan, without any summarization or omission."
---

# Step Decomposition

Split the detail plan into discrete sub-plans.

This skill is a strict splitter and copier. Its job is to completely copy the relevant phase from the detail plan into a separate subplan file without summarizing, compressing, or removing any information.

Step decomposition also carries forward full-lifecycle audit state. If execution still depends on unresolved terminology, external claims, or recheck-required knowledge, the subplan must keep that visible.

## Purpose

A step subplan should help an executor focus on a single phase of execution without losing any detail or context from the original plan.

If the subplan summarizes or omits details from the original phase, it failed.

## Input

- detail plan path
- phase or workstream to extract
- UI constraints inherited from planning when applicable
- current audit blockers or recheck-required items from `task_plan.md` and `findings.md` when relevant

## Output

Write to:
- `docs/plan-for-all/plans/step_subplans/step_subplan_phase{N}.md`

Every generated subplan must start with a TDD guard banner that uses the skill name, not a file path:
- `> Required Skill: Invoke plan-for-all:test-driven-development before executing the detailed steps below.`

This stage runs after `writing-plans` and before execution.

## Deterministic Generation (Preferred)

To avoid accidental summarization by free-form generation, prefer deterministic splitting with:

`powershell -ExecutionPolicy Bypass -File plan-for-all/scripts/split-step-subplans-verbatim.ps1 -DetailPlanPath docs/plan-for-all/plans/YYYY-MM-DD-<topic>-detail.md`

If deterministic generation is available, use it first and only do manual fallback when the script cannot run.

## Extraction Rules

- **Copy everything explicitly**: The subplan must be a full, exact copy of the phase's content from the detailed plan.
- Do NOT summarize.
- Do NOT compress.
- Do NOT remove any details, rationale, examples, or boilerplate.

## Do Not Do These

- do not summarize or shorten the content
- do not omit any context or rationale provided in the detailed plan
- do not change acceptance meaning
- do not hide verification behind vague wording
- do not drop unresolved audit items that still affect the active phase

## Recommended Subplan Structure

The subplan should mirror the structure of the phase exactly as it appears in the detailed plan, prefixed with the required metadata:

```markdown
# Phase N: [Name] — Step Subplan

> Source: `docs/plan-for-all/plans/YYYY-MM-DD-<topic>-detail.md`
> Required Skill: Invoke `plan-for-all:test-driven-development` before executing the detailed steps below.

[Exact literal copy of the phase content from the detail plan]
```

Do not rewrite copied content into template fields such as objective, file list, baseline check, steps, or risks. The phase body must stay in its original structure and wording.

## Audit Carry-Forward Rules

If a phase still depends on external knowledge, the subplan must show one of these states explicitly (copied from the detail plan):
- `verified_official`
- `verified_recent`
- `unresolved`
- `stale_recheck_required`

If execution introduces a new suspicious term later, repair the plan and findings rather than quietly editing the subplan in isolation.

## Self-Check

Before saving the subplan, verify:
- the subplan starts with the required `plan-for-all:test-driven-development` skill banner
- the content is an exact, unsummarized copy of the phase from the detail plan
- no details or rationale were lost or compressed
- active knowledge blockers are still visible when relevant
- the subplan is suitable for a fresh execution session
