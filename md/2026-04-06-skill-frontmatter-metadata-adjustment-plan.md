# plan-for-all Skill Frontmatter Metadata Adjustment Plan

## 背景

用户要求对 `plan-for-all/SKILL.md` 的 yaml metadata 做最小调整，用于验证主 skill 以 `plan-for-all:*` 形式加载子 skill 的行为。

## 目标

- 保持现有 `description` 文案不变
- 在 frontmatter 中追加 `user-invocable: true`
- 在 frontmatter 中追加 `allowed-tools: "Read, Write, Edit, Bash, Glob, Grep, TaskCreate, TaskUpdate, Agent"`
- 不改动正文语义与 hooks

## 冒烟测试

1. 修改前确认 `user-invocable` 与 `allowed-tools` 当前不存在
2. 修改后确认上述两个字段存在
3. 修改后确认 `description` 仍保持原始单行文本

## 执行步骤

1. 使用 `apply_patch` 修改 `plan-for-all/SKILL.md` frontmatter
2. 运行 `Select-String` 冒烟检查关键字段
3. 若检查通过，则停止，不扩大改动范围

## 风险控制

- 不引入新的 metadata 字段，避免把验证范围扩大到未知解析逻辑
- 不改写 `description` 为多行块，避免引入额外变量
- 不触碰子 skill 文件，避免把问题扩散到加载链其他位置
