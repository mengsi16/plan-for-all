# 2026-04-06 Terminology Audit Hard-Gate Plan

## Goal
Upgrade `plan-for-all` so new terms, semantically drifted terms, recent paradigms, and time-sensitive technical knowledge default to mandatory verification before planning may continue. Official sources remain first choice, but recent high-quality non-official sources must be allowed when no official source exists.

## Smoke Check
1. Inspect the current `tech-knowledge-audit` rules for trigger conditions and completion conditions.
2. Inspect `writing-plans` to confirm whether unresolved audit items can still slip through planning.
3. Inspect `task_plan.md` and `findings.md` templates to confirm whether terminology blockers and semantic resolution are first-class tracked artifacts.

## Remediation Steps
1. Tighten `skills/tech-knowledge-audit/SKILL.md`:
   - add high-risk terminology detection
   - make verification default for unfamiliar or semantically risky terms
   - define source priority and recency rules
   - require semantic disambiguation output and unresolved-state handling
2. Tighten `skills/writing-plans/SKILL.md`:
   - make audit a hard gate for new terms and unstable knowledge
   - block detail-plan continuation until required audit items are resolved or explicitly recorded as blockers
3. Update `SKILL.md`:
   - elevate terminology verification to a core workflow rule
   - state that hooks do not replace this gate
4. Update templates:
   - `templates/findings.md` gets a stronger `Tech Knowledge Audit` structure for term meaning, source date, recency, and planning impact
   - `templates/task_plan.md` gets explicit knowledge blockers / audit blockers fields
5. Sync README and workflow docs only where needed so public docs do not misrepresent the new hard gate.

## Verification
- Read back all edited files with UTF-8.
- Search for terms such as `high-risk terminology`, `official sources first`, `recent sources`, `blocker`, `unresolved`, `semantic drift`.
- Confirm `writing-plans` now prevents continuing when mandatory audit items are unresolved.
