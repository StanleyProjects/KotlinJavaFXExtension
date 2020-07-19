echo "pipeline start..."

export BASH_PATH="buildSrc/src/main/resources/script"

PIPELINE_STATUS=0

bash $BASH_PATH/before_script.sh || PIPELINE_STATUS=$?

if test $PIPELINE_STATUS -ne 0; then
  echo "pipeline finish error!"
  exit $PIPELINE_STATUS
fi

VERIFY_STATUS=0
bash $BASH_PATH/verify_script.sh || VERIFY_STATUS=$?

TESTING_STATUS=0
bash $BASH_PATH/testing_script.sh || TESTING_STATUS=$?

#bash $BASH_PATH/verify_script.sh || PIPELINE_STATUS=$?
#if test $PIPELINE_STATUS -ne 0; then
#    echo "pipeline finish error!"
#    exit $PIPELINE_STATUS
#fi

#bash $BASH_PATH/assembly_script.sh || PIPELINE_STATUS=$?
#
#if test $PIPELINE_STATUS -ne 0; then
#    echo "pipeline finish error!"
#    exit $PIPELINE_STATUS
#fi

if test $VERIFY_STATUS -ne 0; then
    echo "Pipeline finish error! Cause verify error."
    exit 1
fi

if test $TESTING_STATUS -ne 0; then
    echo "Pipeline finish error! Cause testing error."
    exit 1
fi

echo "pipeline finish success"

exit 0
