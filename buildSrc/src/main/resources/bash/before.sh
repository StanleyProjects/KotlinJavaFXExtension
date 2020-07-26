echo "before script..."

tasks=(compileKotlin compileTestKotlin)
tasksSize=${#tasks[@]}

timeStartCommon=$(date +%s)
echo "tasks (${tasks[*]}) start..."
for ((i = 0; i < tasksSize; i++)); do
  task="${tasks[$i]}"

  echo "task $task start..."
  timeStart=$(date +%s)
  status=0
  gradle -q clean $task || status=$?
  if test $status -ne 0; then
    echo "task $task error!"
    exit $status
  fi

  echo "\
task $task success $(($(date +%s) - timeStart)) sec
$((i + 1)) of $tasksSize done"
done

echo "tasks (${tasks[*]}) finish $(($(date +%s) - timeStartCommon)) sec"

exit 0
