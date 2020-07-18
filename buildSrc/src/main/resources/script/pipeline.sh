echo "pipeline start..."

export BASH_PATH="buildSrc/src/main/resources/script"

PIPELINE_STATUS=0

#bash $BASH_PATH/before_script.sh || PIPELINE_STATUS=$?
#
#if test $PIPELINE_STATUS -ne 0; then
#    echo "pipeline finish error!"
#    exit $PIPELINE_STATUS
#fi

bash $BASH_PATH/verify_script.sh || PIPELINE_STATUS=$?

if test $PIPELINE_STATUS -ne 0; then
    echo "pipeline finish error!"
    exit $PIPELINE_STATUS
fi

#bash $BASH_PATH/assembly_script.sh || PIPELINE_STATUS=$?
#
#if test $PIPELINE_STATUS -ne 0; then
#    echo "pipeline finish error!"
#    exit $PIPELINE_STATUS
#fi

echo "pipeline finish success"

exit 0
