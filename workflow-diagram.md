# Plan-For-All Workflow Diagram

## Overview

```text
Customer-Facing Convergence -> Implementation Handoff -> Execution Against Verified Steps
```

The workflow exists to keep long-running work grounded in explicit contracts, explicit verification, a single status source, fallback hook guardrails for session recovery, and a full-lifecycle audit mechanism for risky external knowledge.

Current architecture: `brainstorming` is the supervisor; `ui-ux-pro-max` and `writing-plans` are peer stages under that supervisor; then decomposition and TDD execution.

---

## Phase Flow

```mermaid
flowchart TD
    A[No task_plan.md] --> B[Brainstorming owns customer-facing convergence]
    B --> B1{"Will the next question or approach depend on unresolved external technical meaning?"}
    B1 -->|Yes| B2[Run tech-knowledge-audit immediately]
    B2 --> B
    B1 -->|No| C[Brainstorming writes approved design doc]
    C --> D{UI requirements exist?}
    D -->|Yes| E[Run ui-ux-pro-max peer stage first]
    D -->|No| F[Go to writing-plans]
    E --> F
    F --> G[Writing-plans creates detail plan + tracking files]
    G --> H[Step-decomposition creates execution subplans]
    H --> I[Wait for execution approval]
    I --> J[Execute with test-driven-development]
    J --> K[Update task_plan.md then append progress.md]
```

---

## Ownership Model

| Stage / Skill | Primary Responsibility |
|---------------|------------------------|
| `brainstorming` | Supervisor of customer-facing requirement convergence, scope clarification, design approval, and stage routing |
| `ui-ux-pro-max` | Peer stage for UI refinement, runs before writing-plans when UI requirements exist |
| `writing-plans` | Peer stage for implementation handoff, includes technical + UI constraints |
| `step-decomposition` | Build execution-focused subplans from detail plans |
| execution | Follow verified subplans, enforce TDD, keep status honest, and react to new evidence |

---

## Artifact Roles

| File | Role | Owns Status? |
|------|------|--------------|
| `docs/plan-for-all/task_plan.md` | Canonical plan and status tracker | Yes |
| `docs/plan-for-all/findings.md` | Decisions, assumptions, risks, audit results | No |
| `docs/plan-for-all/progress.md` | Append-only factual log | No |
| `docs/plan-for-all/specs/*.md` | Approved design contracts | No |
| `docs/plan-for-all/plans/*.md` | Implementation plans | No |
| `docs/plan-for-all/plans/step_subplans/*.md` | Execution views | No |

---

## Brainstorming Output

The brainstorming phase is complete only when the design doc includes:
- problem statement
- goals
- non-goals
- constraints
- major capabilities or workflows
- acceptance criteria
- risks and open questions

Without these, planning is premature.

Before the next brainstorming question or approach comparison may depend on a public technical term or claim, that item must be audited first rather than pushed onto the user as a guess-driven choice.

If interface-specific refinement is needed, `ui-ux-pro-max` runs as the first peer stage after design approval, and its outputs are merged into `writing-plans` inputs.

---

## Planning Output

Before the detail plan may proceed, mandatory terminology and external-knowledge audit items must be either verified or surfaced as blockers.

The same audit register stays active later: if UI refinement, decomposition, or execution reveals a new risky term or changed external behavior, the item must be registered, rechecked, and reflected back into blockers rather than handled ad hoc.

A healthy detail plan contains:
- contract summary
- phases with objectives
- smoke checks or reproductions
- ordered actions
- verification commands
- exit criteria

A healthy subplan contains:
- current objective
- files in scope
- baseline check
- execution steps
- knowledge blockers or recheck-required items when relevant
- exit criteria

---

## Execution Rules

Execution begins from `task_plan.md`, not from memory.

Hooks stay enabled as fallback guardrails:
- `UserPromptSubmit` reminds the agent to restore context from the planning files
- `PreToolUse` replays current status and active execution context
- `PostToolUse` reminds the agent to sync plan state and run TDD/verification after mutations
- `Stop` reminds the agent to leave truthful status on disk

For each active step:
1. read the active subplan
2. run the baseline check
3. follow the step sequence
4. run verification
5. update `task_plan.md`
6. append a factual log entry to `progress.md`

---

## Anti-Patterns Removed From The Legacy Flow

The remediated system rejects:
- workflow-summary metadata
- pretending hooks alone can replace the written workflow contract
- subplans as raw copies of detail plans
- status claims in multiple files
- implementation-heavy plans with weak verification
- skipping required UI refinement before writing-plans when UI requirements exist
