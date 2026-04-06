# plan-for-all Skill Description Subskills Extension Plan

## 背景

用户要求在主 `SKILL.md` 的 `description` 后面追加一段多行说明，格式参考“三个阶段”示例，但内容改为当前已存在的子 skill 描述。

## 目标

- 保留当前 `description` 的原始首句
- 将 `description` 改为 YAML 多行块格式
- 在首句后追加当前子 skill 清单及用途描述
- 不改动 `user-invocable`、`allowed-tools`、`hooks` 与正文

## 冒烟测试

1. 检查 `description` 已变为多行块标量
2. 检查 6 个当前子 skill 名称都出现在 `description` 中
3. 检查其他 metadata 字段仍然存在

## 执行步骤

1. 使用 `apply_patch` 修改 `plan-for-all/SKILL.md` 的 `description`
2. 使用 `Select-String` 检查关键字段和子 skill 名称
3. 确认只发生预期范围内的 frontmatter 变更
