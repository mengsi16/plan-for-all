# 2026-04-06 Brainstorming Restoration Plan

## Goal
Restore `plan-for-all` brainstorming so it preserves the core `superpowers` behavior: context exploration, one-question-at-a-time requirement gathering, 2-3 approaches, incremental design approval, and hard gating before implementation planning. Keep the new audit behavior only as an attached concern, not as the main workflow.

## Smoke Check
1. Compare current `plan-for-all/skills/brainstorming/SKILL.md` with the original `superpowers` version.
2. Identify which superpowers behaviors were lost or weakened.
3. Restore those behaviors while keeping only the minimal `plan-for-all`-specific additions:
   - docs path change
   - conditional `ui-ux-pro-max` handoff
   - audit intake as a subordinate responsibility

## Remediation Steps
1. Rebuild `skills/brainstorming/SKILL.md` around the original superpowers process flow and hard gate.
2. Keep one-question-at-a-time clarification, 2-3 approaches, section-by-section design approval, and handoff discipline.
3. Reintroduce design/approval semantics strongly enough that `brainstorming` again means requirement convergence rather than static contract templating.
4. Keep audit intake only as an additive rule, not a replacement flow.
5. Sync README wording only if it currently misrepresents brainstorming behavior.

## Verification
- Read back the rewritten `brainstorming` skill in UTF-8.
- Confirm it explicitly contains: hard gate, one question at a time, 2-3 approaches, design approval, handoff to writing-plans.
- Confirm audit wording exists but does not displace the convergence workflow.
