---
name: plan-for-all
description: |
  Use when a task needs a persistent, file-backed planning workflow across requirement convergence, UI refinement, technical planning, decomposition, and TDD execution.
  Orchestrates these child skills in sequence:
  1. brainstorming (supervisor)
  2. ui-ux-pro-max (peer stage, run first when UI exists)
  3. writing-plans (peer stage, run after UI refinement)
  4. step-decomposition
  5. test-driven-development
  Cross-cutting: tech-knowledge-audit at every stage gate.
hooks:
  UserPromptSubmit:
    - hooks:
        - type: command
          command: |
            if [ -f docs/plan-for-all/task_plan.md ]; then
              echo '[plan-for-all-agent] Active plan detected. Read task_plan/findings/progress before acting.';
            fi
  PreToolUse:
    - matcher: "Read|Glob|Grep"
      hooks:
        - type: command
          command: |
            if [ -f docs/plan-for-all/task_plan.md ]; then
              echo '[plan-for-all-agent] === task_plan summary ===';
              head -60 docs/plan-for-all/task_plan.md 2>/dev/null;
            fi
    - matcher: "Bash|Edit|Write"
      hooks:
        - type: command
          command: |
            if [ -f docs/plan-for-all/task_plan.md ]; then
              echo '[plan-for-all-agent] === execution context ===';
              grep -nE 'Current Phase|Active Step|Current Step|Next Action|in_progress|Knowledge Blockers|External Knowledge Status|Recheck Required' docs/plan-for-all/task_plan.md 2>/dev/null || head -40 docs/plan-for-all/task_plan.md 2>/dev/null;
              CURRENT_SUBPLAN=$(grep -oE 'docs/plan-for-all/plans/step_subplans/[^` )]+\.md' docs/plan-for-all/task_plan.md 2>/dev/null | head -1);
              if [ -n "$CURRENT_SUBPLAN" ] && [ -f "$CURRENT_SUBPLAN" ]; then
                echo '[plan-for-all-agent] === step_subplan summary ===';
                head -80 "$CURRENT_SUBPLAN" 2>/dev/null;
              fi
            fi
  PostToolUse:
    - matcher: "Write|Edit"
      hooks:
        - type: command
          command: |
            if echo "$FILE" 2>/dev/null | grep -q 'docs/plan-for-all/plans/.*detail\.md$'; then
              echo '[plan-for-all-agent] detail plan changed. Re-extract step_subplans and sync task_plan.md.';
            fi
            if echo "$FILE" 2>/dev/null | grep -q 'docs/plan-for-all/task_plan\.md$'; then
              echo '[plan-for-all-agent] task_plan.md changed. Append factual log to progress.md.';
            fi
            echo '[plan-for-all-agent] reminder: enforce TDD before implementation and register new audit items.';
  Stop:
    - hooks:
        - type: command
          command: |
            if [ -f docs/plan-for-all/task_plan.md ]; then
              echo '[plan-for-all-agent] Before stop: ensure task_plan.md is current and progress.md has factual updates.';
            fi
---

# Plan-For-All Agent

A file-backed workflow for multi-step work that needs continuity across sessions.

This agent replaces the legacy root SKILL entry and orchestrates child skills with an explicit stage architecture.

## When To Use

Use this agent when:
- the task is large enough to need design, planning, and execution artifacts on disk
- the work may span multiple sessions
- you need a stable source of truth for scope, status, decisions, and risks
- the project needs explicit checkpoints before implementation

Do not use this for tiny one-off edits that do not need persistent planning state.

## Stage Architecture

This agent supervises the following stage chain:

1. **Brainstorming (Supervisor Stage)**
2. **UI Refinement (Peer Stage A, conditional)** using `skills/ui-ux-pro-max/SKILL.md`
3. **Technical Planning (Peer Stage B, required)** using `skills/writing-plans/SKILL.md`
4. **Step Decomposition** using `skills/step-decomposition/SKILL.md`
5. **Execution with TDD** using `skills/test-driven-development/SKILL.md`

Design ownership stays with `brainstorming`. `ui-ux-pro-max` and `writing-plans` are peer stages under the same supervisor, with the required order:
- if UI work exists: run UI Refinement first, then Technical Planning
- if no UI work exists: skip UI Refinement and go directly to Technical Planning

## Full-Lifecycle Audit Model

Audit is cross-cutting and active in all stages.

Every stage must:
- inherit audit state from `docs/plan-for-all/findings.md` and `docs/plan-for-all/task_plan.md`
- register new high-risk terms or unstable external claims
- trigger `skills/tech-knowledge-audit/SKILL.md` before relying on unresolved external facts

Typical audit states:
- `new`
- `needs_verification`
- `high_risk_terminology`
- `verified_official`
- `verified_recent`
- `project_specific_ask_user`
- `unresolved`
- `stale_recheck_required`

## Source Of Truth

`docs/plan-for-all/task_plan.md` is the only canonical progress tracker.

File roles:
- `docs/plan-for-all/task_plan.md`: current status, active stage, active step, blockers
- `docs/plan-for-all/findings.md`: decisions, assumptions, risks, audit register
- `docs/plan-for-all/progress.md`: append-only factual execution log
- `docs/plan-for-all/specs/*.md`: approved design contracts
- `docs/plan-for-all/plans/*.md`: implementation plans
- `docs/plan-for-all/plans/step_subplans/*.md`: execution views

Never store authoritative completion state in `findings.md` or `progress.md`.

## Session Start Routing

At the start of work:
1. If `docs/plan-for-all/task_plan.md` exists, read `task_plan.md`, `findings.md`, and `progress.md`.
2. Route by artifact state:
- no `task_plan.md`: start `skills/brainstorming/SKILL.md`
- design converged and UI refinement required but missing: run `skills/ui-ux-pro-max/SKILL.md`
- approved design exists but no implementation plan: run `skills/writing-plans/SKILL.md`
- detail plan exists but no execution subplan: run `skills/step-decomposition/SKILL.md`
- active subplan exists and user requests implementation: execute with `skills/test-driven-development/SKILL.md`

## Stage Rules

### 1) Brainstorming (Supervisor)

Use `skills/brainstorming/SKILL.md` to converge requirements and write approved design.

Before each major convergence question or approach comparison, if unresolved external technical meaning may distort the next step, run `skills/tech-knowledge-audit/SKILL.md` first.

### 2) UI Refinement (Peer A, conditional)

Use `skills/ui-ux-pro-max/SKILL.md` when the converged design has user-visible interface work that needs dedicated refinement.

UI stage output must be fed back into planning inputs.

### 3) Technical Planning (Peer B, required)

Use `skills/writing-plans/SKILL.md` after convergence and optional UI refinement.

Planning output must include technical behavior, verification, and UI constraints (if present).

### 4) Step Decomposition

Use `skills/step-decomposition/SKILL.md` to produce execution-focused subplans from the detail plan.

### 5) Execute With TDD

Execution follows active `task_plan.md` and `step_subplan`.

Rules:
- confirm active step and acceptance condition before code changes
- use `skills/test-driven-development/SKILL.md` before implementation code
- update `task_plan.md` first, then append facts to `progress.md`
- if reality conflicts with plan, repair plan before continuing

## Required Behaviors

- contract before planning
- UI-first peer ordering when UI stage is required
- smoke checks before implementation
- TDD before production changes
- audit checks at every stage gate
- official sources first for external facts
- task_plan as single status source
- no false completion without verification evidence

## Anti-Patterns

Do not:
- treat UI refinement as optional cosmetics when UI success criteria exist
- run writing-plans before required UI refinement
- skip audit and ask users to settle public technical facts
- mark completion without verification evidence
- duplicate status truth across files

## Completion Condition

The workflow is healthy only when:
- active stage and next action are obvious from `task_plan.md`
- blockers and recheck-required audit items are visible
- findings, progress, and status do not contradict each other
- execution can resume in a new session without hidden context reconstruction
