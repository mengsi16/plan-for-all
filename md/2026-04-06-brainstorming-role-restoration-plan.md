# 2026-04-06 Brainstorming Role Restoration Plan

## Goal
Restore `brainstorming` as the customer-facing product/design convergence layer. It must own requirement discovery, scope clarification, success criteria, and whole-project convergence before any implementation-oriented skill begins. `writing-plans` and `ui-ux-pro-max` must be clearly positioned as downstream implementation-support skills.

## Smoke Check
1. Verify where current docs blur the boundary between customer-facing convergence and implementer-facing design/planning.
2. Restore `brainstorming` language so it explicitly owns overall requirement convergence for backend-only, integrated, and UI-bearing projects alike.
3. Reposition `ui-ux-pro-max` as a subordinate support skill for interface refinement, not a peer planning stage.
4. Reposition `writing-plans` as the implementation handoff layer after customer-facing design is accepted.

## Remediation Steps
1. Rewrite `skills/brainstorming/SKILL.md` around customer-facing convergence responsibilities.
2. Update `SKILL.md` to reflect the corrected hierarchy.
3. Update `README.md` and `README_en.md` where they currently imply the wrong stage ownership.
4. Keep audit intake in brainstorming, but only as a support rule during requirement convergence.

## Verification
- Read back edited files in UTF-8.
- Confirm `brainstorming` explicitly states it is the customer/product convergence layer.
- Confirm `ui-ux-pro-max` and `writing-plans` are described as downstream implementer-facing skills.
- Confirm no doc still presents `ui-ux-pro-max` as a peer owner of requirement convergence.
