# 2026-04-06 Full-Lifecycle-Audit Plan

## Goal
Turn `plan-for-all` audit into a full-lifecycle cross-cutting mechanism instead of a one-time planning gate. Audit must remain active across brainstorming, writing plans, step decomposition, execution, and completion.

## Smoke Check
1. Inspect whether `brainstorming` can currently surface high-risk terminology early enough.
2. Inspect whether `step-decomposition` preserves knowledge blockers and recheck requirements.
3. Inspect whether `task_plan.md` and `findings.md` can represent audit state transitions across phases.
4. Inspect whether the main `SKILL.md` describes audit as a phase-local step or a workflow-wide rule.

## Remediation Steps
1. Upgrade `SKILL.md` to define audit as a workflow-wide mechanism with state transitions and recheck triggers.
2. Upgrade `skills/brainstorming/SKILL.md` so high-risk terminology and unstable external claims are registered during design, before design assumptions become fixed.
3. Upgrade `skills/step-decomposition/SKILL.md` so execution views inherit knowledge blockers, unresolved audit items, and recheck requirements.
4. Strengthen `templates/findings.md` into an audit register with lifecycle state and recheck trigger fields.
5. Strengthen `templates/task_plan.md` so current audit blockers and recheck-required items remain visible in execution.
6. Update supporting public docs only where needed so they describe audit as full-lifecycle rather than a single early gate.

## Verification
- Read back edited files with UTF-8.
- Search for `recheck`, `stale_recheck_required`, `audit register`, `Knowledge Blockers`, `high-risk terminology`, `full-lifecycle`.
- Confirm `brainstorming`, `writing-plans`, and `step-decomposition` all explicitly mention audit responsibilities.
