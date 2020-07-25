SCRIPT_STATUS=0

echo "verify start..."

tasks=(CodeStyle License Readme)
tasksSize=${#tasks[@]}

timeStartCommon=$(date +%s)
echo "tasks (${tasks[*]}) start..."
for ((i = 0; i < tasksSize; i++)); do
  task="${tasks[$i]}"

  echo "task $task start..."
  timeStart=$(date +%s)
  status=0
  gradle -q clean verify"$task" || status=$?
  if test $SCRIPT_STATUS -eq 0 && test $status -ne 0; then SCRIPT_STATUS=1; fi
  sec=$(($(date +%s) - timeStart))
  if test $status -eq 0; then
    echo "task $task success $sec sec"
  else
    if test $SCRIPT_STATUS -eq 0; then SCRIPT_STATUS=1; fi
    echo "task $task error $sec sec"
  fi

  echo "$((i + 1)) of $tasksSize done"
done

echo "tasks (${tasks[*]}) finish $(($(date +%s) - timeStartCommon)) sec"

exit $SCRIPT_STATUS
