# TDD 生命周期失效排查与修复计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 修复 `plan-for-all` 的 `writing-plans` 与 `step-decomposition` 输出，使生成的详细计划和 `step_subplan` 都在最上方先强制声明调用 `plan-for-all:test-driven-development` 技能，再进入详细执行内容。

**Architecture:** 先从 `plan-for-all` 的入口提示词、开发测试阶段模板、技能分发链和守卫脚本中建立调用路径，再用最小冒烟验证确认“未执行 TDD”发生在哪一层。确认根因后，只做最小修复，并补上能卡住该回归的自动化验证。

**Tech Stack:** Markdown 计划文档、PowerShell 检索、Python/脚本化测试、项目内提示词与技能文件。

---

### Task 1: 建立执行链地图

**Files:**
- Inspect: `E:\PostGraduate\plan-for-all\plan-for-all\SKILL.md`
- Inspect: `E:\PostGraduate\plan-for-all\plan-for-all\README.md`
- Inspect: `E:\PostGraduate\plan-for-all\plan-for-all\workflow-diagram.md`
- Inspect: `E:\PostGraduate\plan-for-all\plan-for-all\skills\test-driven-development\SKILL.md`
- Inspect: `E:\PostGraduate\plan-for-all\plan-for-all\scripts\`

- [ ] 找到“代码开发测试”对应入口、阶段切换位置和 TDD 注入点。
- [ ] 列出每一层对 TDD 的声明方式：文案要求、硬性门禁、执行脚本、验证脚本。
- [ ] 标出最可能导致“只宣称、不执行”的断点。

### Task 2: 设计并运行最小冒烟验证

**Files:**
- Create: `E:\PostGraduate\plan-for-all\plan-for-all\md\2026-04-06-tdd-lifecycle-findings.md`
- Test: 项目现有测试入口或新增最小脚本测试

- [ ] 选一个最短路径场景，验证详细计划结构与 `step_subplan` 模板是否都在顶部强制声明 `plan-for-all:test-driven-development`。
- [ ] 记录实际观察到的行为、提示词证据和输出证据。
- [ ] 将结论写入 findings 文档，明确是哪一层失效。

### Task 3: 最小修复

**Files:**
- Modify: `E:\PostGraduate\plan-for-all\plan-for-all\skills\step-decomposition\SKILL.md`
- Modify: `E:\PostGraduate\plan-for-all\plan-for-all\templates\step_subplan.md`
- Modify: `E:\PostGraduate\plan-for-all\plan-for-all\skills\writing-plans\SKILL.md`
- Test: 与修复点相邻的自动化测试文件或新增最小回归测试

- [ ] 先写一个失败测试，证明当前详细计划结构或子计划结构没有在顶部强制声明 `plan-for-all:test-driven-development`。
- [ ] 运行测试，确认失败原因正确。
- [ ] 仅修改根因位置的最小实现，不顺手重构。
- [ ] 再次运行测试，确认通过。

### Task 4: 回归验证与结论

**Files:**
- Update: `E:\PostGraduate\plan-for-all\plan-for-all\md\2026-04-06-tdd-lifecycle-findings.md`

- [ ] 运行与该流程相关的最小测试集和必要冒烟验证。
- [ ] 记录修复前后差异、剩余风险、是否还存在绕过路径。
- [ ] 输出面向用户的中文结论，区分“现象”“根因”“修复”“验证”。
