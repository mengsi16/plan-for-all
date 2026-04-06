# 2026-04-06 Hook Guardrail Restoration Plan

## Goal
Restore necessary hook-based guardrails in `plan-for-all` as fallback protections for session recovery, context compression, and discipline reminders, without reintroducing false claims that hooks alone enforce correctness.

## Smoke Check
1. Compare current `plan-for-all/SKILL.md` against the legacy hook-bearing version to identify removed guardrails.
2. Verify whether current README documents hooks as absent, fake enforcement, or fallback guardrails.
3. Identify the minimum hook set that protects session continuity and TDD/verification reminders.

## Remediation Steps
1. Reintroduce selected hook metadata into `plan-for-all/SKILL.md`.
2. Keep hook language honest in the skill body: hooks are backup guardrails, not the primary workflow contract.
3. Update `README.md`, `README_en.md`, and `workflow-diagram.md` so the documented behavior matches the restored hook design.
4. Run text-based verification to ensure:
   - hook blocks exist in `SKILL.md`
   - README files describe hooks as fallback guardrails
   - no file claims hooks alone guarantee TDD correctness

## Verification
- Read back edited files in UTF-8.
- Search for `hooks:` and `fallback guardrail` / `保底护栏` wording.
- Search for stale wording such as `fake claims that hooks enforce TDD` where it now needs clarification instead of removal.
