echo "pipeline start..."

export BASH_PATH="buildSrc/src/main/resources/bash"

PIPELINE_STATUS=0

#bash $BASH_PATH/before.sh || PIPELINE_STATUS=$? # todo

if test $PIPELINE_STATUS -ne 0; then
  echo "pipeline finish error!"
  exit $PIPELINE_STATUS
fi

VERIFY_STATUS=0
#bash $BASH_PATH/verify.sh || VERIFY_STATUS=$? # todo

TESTING_STATUS=0
bash $BASH_PATH/testing.sh || TESTING_STATUS=$?

if test $VERIFY_STATUS -ne 0; then
    echo "Pipeline finish error! Cause verify error."
    exit 1
fi

if test $TESTING_STATUS -ne 0; then
    echo "Pipeline finish error! Cause testing error."
    exit 2
fi

echo "pipeline finish success"

exit 0
