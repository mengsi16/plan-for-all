#!/usr/bin/env bash
# Check completion status from docs/plan-for-all/task_plan.md

PLAN_FILE="docs/plan-for-all/task_plan.md"

if [ ! -f "$PLAN_FILE" ]; then
  echo "[plan-for-all] $PLAN_FILE not found"
  exit 1
fi

echo "[plan-for-all] reading status from $PLAN_FILE"

echo
ACTIVE_PHASE=$(grep -E '^\| [0-9]+ \|' "$PLAN_FILE" | grep ' in_progress ' | head -1)
PENDING_COUNT=$(grep -E '^\| [0-9]+ \|' "$PLAN_FILE" | grep -c ' pending ' || true)
IN_PROGRESS_COUNT=$(grep -E '^\| [0-9]+ \|' "$PLAN_FILE" | grep -c ' in_progress ' || true)
COMPLETED_COUNT=$(grep -E '^\| [0-9]+ \|' "$PLAN_FILE" | grep -c ' completed ' || true)
TOTAL_COUNT=$(grep -E '^\| [0-9]+ \|' "$PLAN_FILE" | wc -l | tr -d ' ')

echo "Total phases: $TOTAL_COUNT"
echo "Pending: $PENDING_COUNT"
echo "In progress: $IN_PROGRESS_COUNT"
echo "Completed: $COMPLETED_COUNT"

if [ -n "$ACTIVE_PHASE" ]; then
  echo
  echo "Active phase:"
  echo "$ACTIVE_PHASE"
fi

echo
if [ "$TOTAL_COUNT" -gt 0 ] && [ "$COMPLETED_COUNT" -eq "$TOTAL_COUNT" ]; then
  echo "[plan-for-all] all phases completed"
  exit 0
fi

echo "[plan-for-all] work remains"
exit 1
