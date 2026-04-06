# 2026-04-06 Brainstorming-UI-Audit Conflict Fix Plan

## Goal
Resolve the current workflow conflict where `brainstorming + ui-ux-pro-max` can lose design-doc ownership and bypass early terminology audit visibility. Restore a single owner for design convergence and make UI design convergence an explicit child step of brainstorming, not a competing path.

## Smoke Check
1. Verify that `brainstorming` currently says it writes the design doc, but `ui-ux-pro-max` does not explicitly hand control back.
2. Verify that `ui-ux-pro-max` does not currently state any responsibility for forwarding audit-sensitive terms or preserving the design-doc workflow.
3. Verify that the public docs may imply a clean flow even though the sub-skill contract is incomplete.

## Remediation Steps
1. Tighten `skills/brainstorming/SKILL.md` so it explicitly states:
   - brainstorming remains the owner of requirement convergence
   - if UI convergence runs, control returns to brainstorming
   - brainstorming still writes the final design doc
2. Add a `plan-for-all` integration section to `skills/ui-ux-pro-max/SKILL.md` that explicitly states:
   - this skill is a subordinate convergence pass under brainstorming
   - it must not replace the design doc workflow
   - it must surface any new audit-sensitive terminology or external claims back to brainstorming/findings
3. Update `SKILL.md` and README wording only where needed so the documented workflow matches the corrected ownership model.

## Verification
- Read back `brainstorming`, `ui-ux-pro-max`, and `SKILL.md` in UTF-8.
- Confirm `brainstorming` explicitly retains design-doc ownership after UI convergence.
- Confirm `ui-ux-pro-max` explicitly hands control back and forwards audit-sensitive findings.
- Confirm no doc implies that `ui-ux-pro-max` can terminate the brainstorming workflow on its own.
