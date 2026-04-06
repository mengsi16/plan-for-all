from pathlib import Path
import unittest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
STEP_SUBPLAN_TEMPLATE = PROJECT_ROOT / "templates" / "step_subplan.md"
STEP_DECOMPOSITION_SKILL = PROJECT_ROOT / "skills" / "step-decomposition" / "SKILL.md"
WRITING_PLANS_SKILL = PROJECT_ROOT / "skills" / "writing-plans" / "SKILL.md"
REQUIRED_SKILL = "plan-for-all:test-driven-development"


class StepSubplanTddGuardTests(unittest.TestCase):
    def test_step_subplan_template_declares_tdd_skill_at_top(self) -> None:
        template = STEP_SUBPLAN_TEMPLATE.read_text(encoding="utf-8")
        top_section = "\n".join(template.splitlines()[:8])

        self.assertIn(REQUIRED_SKILL, top_section)

    def test_step_decomposition_skill_requires_tdd_skill_header(self) -> None:
        skill_text = STEP_DECOMPOSITION_SKILL.read_text(encoding="utf-8")

        self.assertIn(REQUIRED_SKILL, skill_text)
        self.assertIn("must start", skill_text.lower())

    def test_writing_plans_skill_requires_tdd_skill_header_for_detail_plan(self) -> None:
        skill_text = WRITING_PLANS_SKILL.read_text(encoding="utf-8")
        plan_header_index = skill_text.index("# [Topic] Implementation Plan")
        plan_header_section = skill_text[plan_header_index : plan_header_index + 220]

        self.assertIn(REQUIRED_SKILL, plan_header_section)
        self.assertIn("Required Skill", plan_header_section)


if __name__ == "__main__":
    unittest.main()
