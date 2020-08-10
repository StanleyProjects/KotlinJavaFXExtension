echo "pipeline start..."

export PIPELINE=buildSrc/src/main/resources/bash/pipeline

PIPELINE_STATUS=0

#bash $PIPELINE/before.sh || PIPELINE_STATUS=$? # todo
if test $PIPELINE_STATUS -ne 0; then
    echo "Pipeline finish error! Error in preparation."
    exit 11
fi

VERIFY_STATUS=0
#bash $BASH_PATH/verify.sh || VERIFY_STATUS=$? # todo

TESTING_STATUS=0
#bash $BASH_PATH/testing.sh || TESTING_STATUS=$? # todo

if test $VERIFY_STATUS -ne 0; then
    echo "Pipeline finish error! Cause verify error."
    exit 21
fi

if test $TESTING_STATUS -ne 0; then
    echo "Pipeline finish error! Cause testing error."
    exit 22
fi

bash $PIPELINE/assembly.sh || PIPELINE_STATUS=$?
if test $PIPELINE_STATUS -ne 0; then
    echo "Pipeline finish error! Cause assembly error."
    exit 31
fi

echo "pipeline finish success"

exit 0
