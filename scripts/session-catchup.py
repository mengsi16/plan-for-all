#!/usr/bin/env python3
"""
Session catchup helper for plan-for-all.

This script prints the planning files that should be read first when resuming work.
It does not attempt to reconstruct hidden state from old session transcripts.
"""

from pathlib import Path
import os
import sys

PROJECT_ROOT = Path(sys.argv[1] if len(sys.argv) > 1 else os.getcwd())
PLAN_DIR = PROJECT_ROOT / 'docs' / 'plan-for-all'
FILES = [
    PLAN_DIR / 'task_plan.md',
    PLAN_DIR / 'findings.md',
    PLAN_DIR / 'progress.md',
]


def main() -> None:
    existing = [path for path in FILES if path.exists()]
    if not existing:
        print('[plan-for-all] no planning files found')
        return

    print('[plan-for-all] session catchup')
    print('Read these files first:')
    for path in existing:
        print(f'- {path}')

    task_plan = PLAN_DIR / 'task_plan.md'
    if task_plan.exists():
        print('\n[plan-for-all] canonical status lives in task_plan.md')
        print('[plan-for-all] after reading it, load the active subplan path listed there')


if __name__ == '__main__':
    main()
