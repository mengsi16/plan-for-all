# Systemic Legacy Skill Findings And Remediation

## Purpose

This document diagnoses why the legacy `plan-for-all` skill repeatedly produced low-quality plans and unstable execution behavior, then defines the remediation principles for the new version.

The goal is not to blame a single run. The goal is to identify the structural forces that made bad output the default.

---

## Executive Summary

The legacy `plan-for-all` skill failed because it was not a reliable planning system. It was a document assembly pipeline with weak controls.

It combined five bad properties:

1. It advertised workflow summaries in skill metadata, which encouraged shortcut-following instead of full skill compliance.
2. It moved TDD out of the planning contract and turned it into a late execution reminder.
3. It used hook text as if it were enforcement, but the hooks only emitted reminders after risky actions had already happened.
4. It built an output chain where detail plan mistakes were copied into subplans and then echoed into status files.
5. It had no evidence of skill-level pressure testing, so its failure modes were never closed.

As a result, the skill optimized for producing many files that looked complete instead of producing a plan that constrained behavior and reduced risk.

---

## Symptom Pattern

The old system reliably produced the same class of failure:

- design docs that mixed goals, assumptions, and unstable facts without locking contracts
- implementation plans that embedded large amounts of speculative code
- subplans that duplicated those mistakes instead of extracting execution-critical information
- progress files that reported completion without a trustworthy source of truth
- TDD language present in documentation but absent in actual sequencing

This was not random drift. It was the expected output of the workflow design.

---

## Root Cause Analysis

### 1. Metadata Taught A Shortcut Instead Of A Trigger

The legacy main skill description summarized the workflow itself instead of only describing when to use the skill.

That caused the model to absorb a shortcut like this:

`design -> plan -> execute -> hooks will force TDD later`

Once that shortcut is learned from metadata, the model has less incentive to read and obey stricter body instructions. The body becomes advisory text, not binding procedure.

**Why this matters:** skill metadata is read earlier and more reliably than the body. If metadata contains process summary, the model often follows the summary and skips the nuance.

**Remediation:** descriptions must contain trigger conditions only. Workflow belongs in the body.

### 2. TDD Was Demoted From Design Constraint To Execution Reminder

The old system explicitly said that writing-plans and step-decomposition should not embed TDD detail, and that TDD would be handled later in execution by hooks.

This broke the core TDD sequence.

Real TDD requires:

- define observable behavior first
- write a failing test first
- confirm failure for the expected reason
- only then write implementation

The legacy system instead encouraged:

- produce design doc
- generate detail plan with implementation-shaped content
- split into step files
- remind the executor later to do TDD

At that point the executor is already biased by the implementation text. TDD is no longer driving behavior; it is chasing behavior.

**Why this matters:** if the plan does not require smoke tests, failing tests, and verification checkpoints before implementation, the execution phase starts from the wrong mental model.

**Remediation:** planning must encode test-first behavior. TDD cannot be delegated to a post-edit reminder.

### 3. Hooks Created The Illusion Of Enforcement

The legacy main skill relied heavily on hook text. It claimed to “force” TDD, but the hooks only printed instructions.

That is not enforcement.

The hooks had several structural weaknesses:

- they ran after edits as well as before, which is already too late for test-first discipline
- they did not verify that a failing test existed
- they did not verify a red-green transition
- they did not block further action when requirements were violated
- they depended on brittle command matching for file-modifying Bash patterns

The result was a pseudo-control layer: it made the process look strict while leaving behavior unconstrained.

**Why this matters:** reminder systems are weak against local momentum. If code already exists, most agents will rationalize forward rather than rewind.

**Remediation:** remove fake claims of enforcement. Put hard requirements directly into phase outputs and checklists.

### 4. Detail Plan Was Asked To Contain Too Much Implementation

The legacy writing-plans skill required exact paths, exact commands, and often complete code blocks in the plan.

That caused several downstream problems:

- the plan became a speculative implementation draft, not an execution contract
- large code blocks crowded out acceptance criteria and risk analysis
- detail plan quality became highly sensitive to early misunderstandings
- later decomposition stages inherited implementation bias

A good plan should clarify behavior, boundaries, checkpoints, and verification. It should not try to pre-write the whole feature unless the task is tiny and deterministic.

**Why this matters:** plans should reduce ambiguity, not freeze guesses.

**Remediation:** detail plans should center on contracts, file responsibilities, smoke tests, failure checkpoints, and minimal execution steps. Large implementation code belongs in execution, not planning.

### 5. Step Decomposition Was Designed As An Error Multiplier

The old step-decomposition skill treated itself as a raw copier. It prohibited summarization and prohibited meaningful restructuring.

This meant:

- if the detail plan was wrong, the subplan stayed wrong
- if the detail plan was verbose, the subplan stayed verbose
- if the detail plan contained speculative code, the subplan preserved it
- if the executor needed a focused execution view, the decomposition stage refused to create one

In other words, step decomposition did not decompose intent. It copied text.

**Why this matters:** an execution view should distill action, constraints, and validation. It should not be a second copy of a bloated upstream file.

**Remediation:** convert decomposition from raw copying into execution extraction. Preserve constraints, not noise.

### 6. Status Management Had No Single Source Of Truth

The old system wrote status across `task_plan.md`, `progress.md`, and step subplans without a strict ownership model.

That enabled contradictory states such as:

- plan marked completed while current phase remained pending
- progress log claiming all phases complete while subplan checkboxes remained untouched
- findings files drifting into status reporting

This was not user error. The system never defined which file was authoritative.

**Why this matters:** once status can be claimed in multiple files, completion becomes performative.

**Remediation:** make `task_plan.md` the only progress truth source. Other files may reference it but must not declare canonical state.

### 7. Research And Planning Were Not Properly Separated

The tech audit concept was directionally right, but the old system let research artifacts bleed into design certainty too quickly.

It did not force a clear distinction between:

- temporally unstable facts that must be verified
- product or architecture decisions that require judgment
- external compatibility assumptions that need explicit contract boundaries

This made planning look evidence-based while still smuggling in weak assumptions.

**Why this matters:** research should bound uncertainty, not disguise it.

**Remediation:** audit only what is time-sensitive or unfamiliar, record uncertainty explicitly, and require the plan to state which assumptions remain open.

### 8. The Skill Was Not Built With Skill-Level TDD

The most important meta-level failure is that the skill itself shows no sign of having been validated under pressure scenarios.

A workflow skill should be tested against concrete cases such as:

- greenfield feature planning
- bugfix planning under unclear root cause
- refactor planning in an existing codebase
- tasks with unstable external dependencies

Without those tests, obvious loopholes survive:

- workflow summaries in metadata
- fake enforcement claims
- contradictory file roles
- copying instead of extraction
- TDD language without TDD sequencing

**Why this matters:** a skill is process code. If it is not tested like process code, it will fail like process code.

**Remediation:** future updates must include pressure scenarios and failure-mode review before release.

---

## Contributing Design Conflicts

The legacy system also contained internal tensions that nudged the model toward garbage output:

### A. “Steps should be 2-5 minutes” vs “plans should include complete code”

This pair creates a perverse incentive to produce many tiny steps filled with oversized code blocks.

### B. “Subplans must not summarize” vs “subplans are for execution”

Execution views need compression and signal extraction. Refusing summarization defeats their purpose.

### C. “TDD is mandatory” vs “TDD happens later via hooks”

This is a direct sequencing conflict. The later instruction wins in practice because it is easier.

### D. “Progress must be tracked everywhere” vs no truth-source definition

Multiple status files without authority rules guarantee drift.

---

## Systemic Failure Mechanism

The old system followed this failure loop:

1. Metadata teaches a three-stage shortcut.
2. Brainstorming produces a broad spec without strong behavioral contracts.
3. Writing-plans turns that spec into implementation-shaped text.
4. Step-decomposition copies the text instead of extracting execution intent.
5. Status files are generated as if work now has structure.
6. Execution begins with implementation bias already embedded.
7. Hook messages mention TDD, but too late and without enforcement.
8. The resulting artifact bundle looks complete while remaining weakly verified.

That loop explains why the quality failures felt repetitive. The system was repetitive.

---

## Remediation Principles

The new version of `plan-for-all` should follow these principles.

### 1. Trigger Descriptions Only

Skill descriptions must say when to use the skill, not how the workflow works.

### 2. Contract Before Plan

Brainstorming must produce:

- problem statement
- success criteria
- non-goals
- key constraints
- acceptance conditions
- open questions and risks

Without that contract, planning is guessing.

### 3. Plan Before Code, Test Before Implementation

Writing-plans must require:

- smoke check first
- failing test or failure reproduction first
- smallest viable implementation step
- explicit verification command per step

### 4. Execution Views Must Extract, Not Copy

Subplans should keep:

- current goal
- relevant files
- ordered actions
- test commands
- completion criteria

They should remove speculative bulk.

### 5. Single Source Of Truth For Status

`task_plan.md` owns status.

- `progress.md` is append-only factual logging
- `findings.md` stores findings, assumptions, risks, and decisions
- subplans never claim global completion

### 6. No Fake Enforcement Language

If the system does not block or verify, it must not claim to enforce.

### 7. Research Should Reduce Uncertainty, Not Simulate Confidence

Tech audit should only target unstable or unfamiliar knowledge, and it must surface unresolved assumptions explicitly.

### 8. The Skill Itself Must Be Evaluated

Any future revision should be tested against real planning scenarios before release.

---

## Required Changes

The remediation work should at minimum:

1. Rewrite `plan-for-all/SKILL.md` to remove workflow-summary metadata and fake enforcement claims.
2. Rewrite `skills/writing-plans/SKILL.md` so plans are behavior-first and verification-first.
3. Rewrite `skills/step-decomposition/SKILL.md` so subplans become execution views rather than copies.
4. Tighten `skills/brainstorming/SKILL.md` to require contracts, non-goals, and acceptance criteria.
5. Narrow `skills/tech-knowledge-audit/SKILL.md` so it audits time-sensitive knowledge instead of validating every thought.
6. Update templates so status ownership and file responsibilities are explicit.

---

## Bottom Line

The old `plan-for-all` skill did not fail because one model made a bad call.

It failed because the system rewarded the appearance of rigor over actual control.

The remediation target is therefore not “better wording.” It is a different operating model:

- trigger-based metadata
- contract-first planning
- explicit smoke and failure checks
- execution-focused subplans
- single-source status tracking
- no pretend enforcement
- skill-level validation for future revisions
