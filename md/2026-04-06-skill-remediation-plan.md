# plan-for-all Skill Remediation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans or an equivalent disciplined execution workflow. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 诊断旧版 `plan-for-all` skill 的系统性失效原因，并重构主 skill 与关键子 skill，使其重新围绕“前置约束、单一状态源、测试先行、可验证执行”工作。

**Architecture:** 先写一份系统问题诊断文档，明确 metadata、流程编排、hook、状态管理和 skill authoring 方法论上的根因。随后收敛主 skill 的职责边界，移除伪强制机制和错误扩散机制，再把 `writing-plans`、`step-decomposition`、`brainstorming`、`tech-knowledge-audit` 调整成围绕契约、冒烟测试和执行闭环协作的子 skill。

**Tech Stack:** Markdown skills, shell hooks, prompt workflow design

---

## Scope

- 仅整改 `plan-for-all/` 目录
- 不修改 `.claude/skills/plan-for-all`
- 产出一份英文命名的系统诊断文档
- 产出可替换当前主 skill 的新版本文本

### Task 1: 诊断旧实现

**Files:**
- Create: `plan-for-all/systemic-legacy-skill-findings-and-remediation.md`
- Inspect: `plan-for-all/SKILL.md`
- Inspect: `plan-for-all/skills/brainstorming/SKILL.md`
- Inspect: `plan-for-all/skills/writing-plans/SKILL.md`
- Inspect: `plan-for-all/skills/step-decomposition/SKILL.md`
- Inspect: `plan-for-all/skills/tech-knowledge-audit/SKILL.md`
- Inspect: `plan-for-all/skills/test-driven-development/SKILL.md`

- [ ] **Step 1: 归纳根因类别**

覆盖以下维度：
- metadata / description 是否诱导 shortcut
- 流程是否把 TDD 后移
- hook 是否真正 enforce
- 子 skill 是否复制并放大错误
- 状态文件是否存在单一真源
- skill 是否经过 pressure test

- [ ] **Step 2: 写入诊断文档并给出整改原则**

要求：
- 用系统归因，不停留在表层现象
- 每条问题都要对应整改方向
- 诊断语言直接，避免空泛表述

### Task 2: 重构主 skill

**Files:**
- Modify: `plan-for-all/SKILL.md`
- Inspect: `plan-for-all/templates/*.md`
- Inspect: `plan-for-all/workflow-diagram.md`

- [ ] **Step 1: 收敛 frontmatter 与触发描述**

要求：
- description 只描述触发条件，不总结 workflow
- 去掉与 skill authoring 原则冲突的 metadata
- 删除“hook 会强制 TDD”这类虚假承诺

- [ ] **Step 2: 重新定义三阶段职责**

要求：
- Brainstorming 只负责需求/契约/spec
- Writing Plans 只负责可执行计划，不生成实现草稿大段代码
- Execute 只负责按计划执行，不依赖提醒式 hook 代替约束

- [ ] **Step 3: 明确单一状态源**

要求：
- `task_plan.md` 成为唯一进度真源
- `progress.md` 只追加事实日志
- `findings.md` 只记录研究/决策/风险，不声明完成状态

### Task 3: 重构关键子 skill

**Files:**
- Modify: `plan-for-all/skills/writing-plans/SKILL.md`
- Modify: `plan-for-all/skills/step-decomposition/SKILL.md`
- Modify: `plan-for-all/skills/brainstorming/SKILL.md`
- Modify: `plan-for-all/skills/tech-knowledge-audit/SKILL.md`
- Optionally modify: `plan-for-all/templates/task_plan.md`
- Optionally modify: `plan-for-all/templates/progress.md`
- Optionally modify: `plan-for-all/templates/findings.md`
- Optionally modify: `plan-for-all/templates/step_subplan.md`

- [ ] **Step 1: 修复 writing-plans**

要求：
- 计划以行为、契约、冒烟测试和验证命令为核心
- 不再要求“完整实现代码进计划”
- 对 bugfix / greenfield / refactor 三类任务给出不同 planning 模板

- [ ] **Step 2: 修复 step-decomposition**

要求：
- 从“原文搬运器”改为“执行视图提取器”
- 允许压缩样板、保留关键约束、突出测试与验收
- 不复制整段实现代码

- [ ] **Step 3: 修复 brainstorming 与 audit 的边界**

要求：
- brainstorming 增加契约、成功标准、非目标、验收标准
- audit 只负责时间敏感知识，不替代设计判断

### Task 4: 一致性复核

**Files:**
- Verify: `plan-for-all/SKILL.md`
- Verify: `plan-for-all/skills/*.md`
- Verify: `plan-for-all/templates/*.md`

- [ ] **Step 1: 检查前后约束是否一致**
- [ ] **Step 2: 检查是否仍存在“伪强制 TDD”描述**
- [ ] **Step 3: 检查是否仍存在错误扩散路径**
