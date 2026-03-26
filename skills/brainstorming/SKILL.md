---
name: brainstorming
description: "需求探索与设计阶段 — 通过逐个提问收敛需求，提出方案并获得用户批准。支持双阶段：Phase 1 需求收敛 → Phase 2 前端设计收敛（可选）。将设计文档写入硬盘。"
---

# Brainstorming — 需求探索与设计

通过自然对话将想法转化为完整的设计方案。

**前置条件：** 已阅读 `task_plan.md`（如果存在），了解项目状态

## 核心原则

- **一次一问** — 不要一次问多个问题
- **多选优先** — 降低用户回答难度
- **YAGNI** — 果断删除不必要的功能
- **渐进确认** — 每个设计 section 获得批准后再继续

---

## 双阶段流程

```
Phase 1: 需求收敛 → Phase 2: 前端设计收敛（可选）→ 过渡到 writing-plans
```

| 阶段 | 目的 | 产出 |
|------|------|------|
| Phase 1 | 需求收敛 | `docs/plan-for-all/specs/YYYY-MM-DD-<feature>-design.md` |
| Phase 2 | 前端设计收敛 | 更新设计文档，加入 UI/UX 设计系统 |

---

# Phase 1: 需求收敛

## Step 1: 检查项目上下文

检查是否存在现有的规划文件：

```bash
if [ -f task_plan.md ]; then
  echo "发现已有 task_plan.md，读取并恢复上下文..."
  cat task_plan.md
  cat findings.md
  cat progress.md
fi
```

如果项目已存在，记录当前进展，继续从中断处进行。

---

## Step 2: 探索需求（逐个提问）

从以下维度依次提问（每次一个），理解：
1. **产品定位** — C端/B端、工具/娱乐/社交
2. **核心功能** — 主要解决什么问题
3. **用户交互** — 关键操作流程
4. **数据需求** — 需要存储什么
5. **技术偏好** — 技术栈/框架/存储
6. **设计风格** — 简洁/丰富/品牌感

**示例：**

> Q1: 这个应用是给自己用还是给别人用？
> - A: 自己用（个人效率工具）
> - B: 给团队用（协作平台）
> - C: 通用（任何人都能用）

---

## Step 3: 提出方案（2-3 个选项）

根据问题回答，提出具体方案：
- 方案 A（推荐）: 适合 X 场景，优势是 Y
- 方案 B: 适合 X 场景，优势是 Y
- 方案 C: 适合 X 场景，优势是 Y

**每次都要有推荐**，并说明原因。

---

## Step 4: 呈现设计（分 section 获得批准）

当理解足够时，呈现设计：

```markdown
## 设计方案：[项目名称]

### 架构
[2-3 句话描述整体架构]

### 核心组件
- 组件 A: 负责 X，与组件 B 通过 Y 接口交互
- 组件 B: ...

### 数据流
[数据如何创建 → 存储 → 展示]

### 技术选型
- 前端: X（原因）
- 存储: Y（原因）

---

批准后继续下一个 section，直到整个设计获得批准。
```

---

## Step 5: 写入设计文档（Phase 1 产出）

```markdown
# [项目名称] 设计文档
**日期:** YYYY-MM-DD
**状态:** Phase 1 已批准

## 1. 背景与目标
[一句话目标]

## 2. 设计决策
| 决策点 | 选择 | 原因 |
|--------|------|------|
| 存储方案 | IndexedDB | 离线可用 |
| ... | ... | ... |

## 3. 架构
[详细架构描述]

## 4. 组件设计
[每个组件的职责、接口、状态]

## 5. 数据模型
[数据结构定义]
```

保存到：`docs/plan-for-all/specs/YYYY-MM-DD-<feature>-design.md`

---

## Step 6: 询问是否进入 Phase 2

Phase 1 完成后，询问用户：

> "Phase 1 需求收敛已完成，设计文档已保存到 `docs/plan-for-all/specs/YYYY-MM-DD-<feature>-design.md`。
>
> **是否需要进入 Phase 2：前端设计收敛？**
>
> Phase 2 将调用 UI/UX Pro Max 技能，帮你：
> - 确定设计风格（Minimalism / Brutalism / Glassmorphism 等）
> - 选择配色方案
> - 选定字体搭配
> - 生成完整的设计系统建议
>
> - A: 是，继续 Phase 2（推荐）
> - B: 跳过，直接进入规划阶段"

- **选择 A**：进入 Phase 2
- **选择 B**：跳到 Step 7（过渡到 Writing Plans）

---

# Phase 2: 前端设计收敛

**触发条件：** 用户选择进入 Phase 2

**前置准备：** 读取 `skills/brainstorming/skills/ui-ux-pro-max/SKILL.md` 获取 UI/UX 设计系统

---

## Step 2-1: 分析产品类型和设计关键词

从 Phase 1 的设计文档中提取：
- **产品类型**：SaaS / 电商 / 社交 / 工具 / 内容平台
- **目标用户**：C端 / B端
- **设计风格关键词**：简洁 / 现代 / 品牌感 / 内容优先 / 暗色模式

---

## Step 2-2: 生成设计系统（必需）

使用 ui-ux-pro-max 的 `--design-system` 生成完整设计系统：

```bash
python3 skills/brainstorming/skills/ui-ux-pro-max/scripts/search.py "<产品类型> <行业> <风格关键词>" --design-system [-p "项目名称"]
```

**示例：**
```bash
python3 skills/brainstorming/skills/ui-ux-pro-max/scripts/search.py "fintech dashboard modern dark" --design-system -p "Finance App"
```

**输出包含：**
- **Style**: 推荐的设计风格及理由
- **Color Palette**: 主色、辅色、背景色、文字色
- **Typography**: 字体搭配建议
- **Effects**: 阴影、圆角、动效建议
- **Anti-Patterns**: 需要避免的设计陷阱

---

## Step 2-3: 补充搜索（如需要）

根据需要查询更多细节：

```bash
# 查询 UX 最佳实践
python3 skills/brainstorming/skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain ux [-n <数量>]

# 查询配色方案
python3 skills/brainstorming/skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain color [-n <数量>]

# 查询字体搭配
python3 skills/brainstorming/skills/ui-ux-pro-max/scripts/search.py "<keyword>" --domain typography [-n <数量>]
```

---

## Step 2-4: 呈现 UI/UX 设计系统

向用户呈现设计系统建议，征求批准：

```markdown
## Phase 2: UI/UX 设计系统

### 设计风格
**推荐风格:** [风格名称]
**理由:** [2-3 句话说明为什么适合该项目]

### 配色方案
| 角色 | 色值 | 用途 |
|------|------|------|
| Primary | #XXXXXX | 主要按钮、链接 |
| Secondary | #XXXXXX | 次要元素 |
| Background | #XXXXXX | 背景色 |
| Surface | #XXXXXX | 卡片、面板 |
| Text | #XXXXXX | 正文文字 |

### 字体搭配
- **标题:** [字体名称]
- **正文:** [字体名称]
- **代码/数据:** [字体名称]

### 设计规范
- **圆角:** [尺寸]
- **阴影:** [风格]
- **动效:** [时长、缓动]
- **间距系统:** 4pt / 8pt / 16pt / 24pt / 32pt

### 需要避免的反模式
- [ ] 避免项 1
- [ ] 避免项 2

---

**批准后继续下一个 section。**
```

---

## Step 2-5: 更新设计文档

将 UI/UX 设计系统整合到设计文档中：

```markdown
# [项目名称] 设计文档
**日期:** YYYY-MM-DD
**状态:** Phase 1 + Phase 2 已批准

## 1. 背景与目标
[一句话目标]

## 2. 设计决策
| 决策点 | 选择 | 原因 |
|--------|------|------|
| ... | ... | ... |

## 3. UI/UX 设计系统

### 3.1 设计风格
**风格:** [风格名称]
**理由:** [原因]

### 3.2 配色方案
[配色表格]

### 3.3 字体系统
[字体搭配]

### 3.4 间距与圆角
[规范]

### 3.5 动效规范
[时长、缓动、原则]

## 4. 架构
[架构描述]

## 5. 组件设计
[组件列表]

## 6. 数据模型
[数据结构]
```

保存到：`docs/plan-for-all/specs/YYYY-MM-DD-<feature>-design.md`（覆盖更新）

---

# Step 7: 过渡到 Writing Plans

Phase 1 或 Phase 2 完成后：

> "设计已确认并保存到 `docs/plan-for-all/specs/YYYY-MM-DD-<feature>-design.md`。
>
> 现在进入规划阶段，我将根据设计文档创建详细的实现计划。"

**过渡到 `writing-plans` 阶段。**

---

## 与 Writing Plans 的衔接

Brainstorming 的输出是设计文档（spec），是 Writing Plans 的输入。

```
设计文档 (spec)
    ↓
Writing Plans
    ↓
detail_plan.md + step_subplan_*.md + task_plan.md
```
