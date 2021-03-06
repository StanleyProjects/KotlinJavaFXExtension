SCRIPT_STATUS=0

status=0
task="lib:test"
echo "run task $task"
gradle -q clean $task || status=$?
if test $status -eq 0; then
  echo "task $task success"
else
  if test $SCRIPT_STATUS -eq 0; then SCRIPT_STATUS=1; fi
  echo "task $task error"
fi

status=0
task="lib:verifyTestCoverage"
echo "run task $task"
gradle -q $task || status=$?
if test $status -eq 0; then
  echo "task $task success"
else
  if test $SCRIPT_STATUS -eq 0; then SCRIPT_STATUS=1; fi
  echo "task $task error"
fi

exit $SCRIPT_STATUS
