# plan-for-all UI Design Convergence Update Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use disciplined text-first editing and verify cross-file consistency after changing workflow behavior.

**Goal:** 将 `ui-ux-pro-max` 接入 `brainstorming` 阶段，改成“对前端/界面驱动项目条件性强制进入 UI 设计收敛阶段”，同时保持非 UI 项目不被无意义流程污染。

**Architecture:** 在 `brainstorming` 中新增“是否存在关键 UI 设计风险”的判定门。只有当项目包含用户可见界面且界面质量、信息架构或交互流程会影响成败时，才强制进入 `ui-ux-pro-max`。随后同步主 skill、README 和流程说明，确保文本与流程一致。

**Tech Stack:** Markdown skills, workflow docs

---

## Scope

- Modify: `plan-for-all/skills/brainstorming/SKILL.md`
- Modify: `plan-for-all/SKILL.md`
- Modify: `plan-for-all/README.md`
- Modify: `plan-for-all/README_en.md`
- Modify: `plan-for-all/workflow-diagram.md`

## Tasks

- [ ] 在 `brainstorming` 中加入 UI 设计判定门
- [ ] 明确哪些项目类型必须进入 `ui-ux-pro-max`
- [ ] 明确哪些项目类型直接跳过该阶段
- [ ] 同步主 skill 对阶段职责的描述
- [ ] 同步 README 和流程图，避免新旧文案冲突
