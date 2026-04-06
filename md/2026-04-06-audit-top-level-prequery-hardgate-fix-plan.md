# 2026-04-06 Audit Top-Level Prequery Hard-Gate Fix Plan

## Goal
Restore `plan-for-all` so audit sits above phase-specific behavior: when a task introduces ambiguous, drifting, unfamiliar, or time-sensitive technical terminology or external claims, the workflow must verify them first, before further requirement convergence depends on them. Keep `brainstorming` as the main requirement-convergence skill, but prevent it from asking the user to resolve facts that should be verified from authoritative sources.

## Constraints
- Do not replace or redesign the main `brainstorming` workflow.
- Add audit as a higher-level cross-cutting gate that applies before and during brainstorming, planning, decomposition, execution, and completion.
- Prefer official documentation, official specifications, official repos, official release notes, and official blogs.
- If no authoritative official source exists, allow recent high-quality sources and record uncertainty explicitly.

## Smoke Check
1. Verify the current routing enters `brainstorming` before any mandatory audit call.
2. Verify `brainstorming` currently registers risky terms but does not require immediate verification before asking further convergence questions.
3. Verify the current hard gate for technical knowledge audit exists mainly in `writing-plans`, not above the full workflow.
4. Verify public docs currently claim “new terms default to mandatory verification” while the concrete Phase 1 behavior still allows “ask first, verify later”.

## Remediation Steps
1. Tighten top-level `SKILL.md` so audit becomes a pre-question and pre-dependence gate for the whole workflow, including brainstorming.
2. Add the minimum necessary rules to `skills/brainstorming/SKILL.md` so it must pause and trigger immediate audit when a term or external claim would otherwise distort the next question or proposed approaches.
3. Keep `skills/tech-knowledge-audit/SKILL.md` as the verification engine, but make its handoff semantics explicit for brainstorming-time audit.
4. Update `skills/writing-plans/SKILL.md` only where needed so planning remains a later hard gate without being the first place audit can happen.
5. Sync `README.md`, `README_en.md`, and `workflow-diagram.md` so the documented behavior matches the repaired execution model.

## Verification
- Read all edited files back with UTF-8.
- Search for wording that proves:
  - audit is above brainstorming, not only inside planning
  - ambiguous technical terms trigger verification before further questioning depends on them
  - official sources remain first priority
  - full-lifecycle recheck behavior still exists
- Manually confirm `brainstorming` still owns requirement convergence, one-question-at-a-time behavior, and approach comparison, but no longer treats externally verifiable ambiguity as something to push onto the user.
