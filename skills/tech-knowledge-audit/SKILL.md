---
name: tech-knowledge-audit
description: Use when planning depends on unstable, unfamiliar, recently-evolving, or semantically ambiguous technical knowledge that must be verified before the plan can rely on it.
---

# Tech Knowledge Audit

Verify technical knowledge before it becomes a planning dependency.

This skill is not optional when the plan depends on terms, technologies, providers, APIs, protocols, or paradigms whose meaning may be stale, drifting, ambiguous, or recently changed.

## Default Rule

Default to verification for external technical knowledge that could affect planning correctness.

Treat audit as a phase-entry gate for every stage in plan-for-all:
- brainstorming
- ui-ux-pro-max (when used)
- writing-plans
- step-decomposition
- execution with TDD

At each stage start, re-check inherited unresolved or stale items before making stage-local decisions.

Do not rely on memory for:
- new or recently popular terms
- old terms whose meaning may have drifted
- provider, API, SDK, protocol, or framework behavior
- version-sensitive configuration or commands
- claims about what is currently supported
- ecosystem conventions that may have changed in recent months

Skipping verification requires a concrete reason, not a vague feeling that the item is probably stable.

## High-Risk Terminology

Treat an item as `high_risk_terminology` and verify it before planning continues when any of these are true:
- the term is unfamiliar
- the user is using a word in a meaning that differs from common everyday meaning
- the term has recently become common in a specific engineering subculture
- the term likely has multiple meanings across ecosystems
- the term appears old, but the current task may rely on a newer meaning
- misunderstanding the term would change architecture, interfaces, workflow, or implementation

Examples:
- `skill` in agent tooling contexts
- `Harness` when the current community meaning differs from older workflow meanings
- any model, provider, protocol, or orchestration term whose usage is still settling

## When To Audit

Audit an item when any of these are true:
- the information is version-sensitive
- the API, provider, SDK, or framework behavior may have changed
- the plan depends on a protocol or integration detail you are not confident about
- the term or framework is unfamiliar enough that guessing would be risky
- the term is high-risk terminology
- the user explicitly wants up-to-date confirmation
- the item describes a recent engineering practice, ecosystem norm, or agent pattern

Do not audit purely local project terminology by searching the internet. Read the local repo or ask the user instead.

This skill is not only for planning-time use. If brainstorming cannot safely ask the next clarifying question or compare approaches without first resolving a public technical meaning, run the audit immediately and then return to brainstorming.

Likewise, if UI refinement, decomposition, or execution introduces a new external term, register and verify it before continuing stage-critical assumptions.

## Source Priority

Use this order unless the user says otherwise:

1. local project docs, code, and checked-in references for project-specific terms
2. official docs, official repos, official specifications, official release notes, official changelogs
3. official blog posts or official announcements
4. if no authoritative official source exists, use recent high-quality non-official sources such as:
   - recent papers
   - recent engineering blogs from credible practitioners
   - recent ecosystem references with clear dates and strong technical detail
5. if sources conflict or remain weak, record the uncertainty as unresolved

## Recency Rule

For high-risk terminology, recently evolving practices, and topics without official documentation:
- prefer recent sources
- reject stale sources as the main basis for current planning
- record the source date or publication date when possible
- if the newest reliable material is still ambiguous, keep the item unresolved

Old blog posts are not acceptable as current truth when the topic is evolving.

## Output Location

Record results in `docs/plan-for-all/findings.md` under `## Tech Knowledge Audit`.

## Workflow

1. List the technical assumptions and terms the plan may rely on.
2. Mark each item as one of:
   - `needs_verification`
   - `high_risk_terminology`
   - `stable_enough`
   - `project_specific_ask_user`
3. For every `needs_verification` or `high_risk_terminology` item, verify before planning continues.
4. For each audited item, capture:
   - item name
   - why it was risky
   - current meaning in this task
   - common wrong interpretation if relevant
   - source and source date
   - status
   - planning impact
5. If the item cannot be verified well enough, mark it unresolved and surface it as a planning blocker.
6. Return control to planning only after blockers are explicit.

Use `project_specific_ask_user` narrowly:
- repo-private naming
- stakeholder-private meaning
- business intent or preference
- information that only the user can know from private context

Do not use `project_specific_ask_user` for public ecosystem facts such as provider support, protocol semantics, compatibility claims, SDK behavior, or currently documented product behavior when those are externally verifiable.

## What To Record

For each audited item, capture:
- item name
- category
- status
- source
- source date or recency note
- current meaning in this task
- planning impact

Example structure:

```markdown
## Tech Knowledge Audit

| Item | Category | Status | Source | Date | Current Meaning | Planning Impact |
|------|----------|--------|--------|------|-----------------|-----------------|
| skill | high_risk_terminology | verified_recent | official docs + recent ecosystem references | 2026-04 | Anthropic-style reusable agent skill protocol | planning assumes skill files and trigger semantics, not generic capability language |

### Notes
- `skill`: in this task, the term refers to the current agent-tooling convention, not the generic English word.
- unresolved items must also appear in `task_plan.md` blockers.
```

## Completion Condition

The audit is complete only when the plan can clearly state:
- which technical assumptions are verified
- which high-risk terms have an explicit current meaning
- which sources were used and how recent they are
- which items remain unresolved and therefore block or constrain planning

## Anti-Patterns

Do not do these:
- treat unfamiliar terms as if the common meaning must be correct
- assume older knowledge is good enough for evolving ecosystems
- use non-official sources when official sources exist and are sufficient
- use stale sources as current truth for fast-moving topics
- write research dumps with no planning impact
- hide unresolved uncertainty
