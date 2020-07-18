echo "verify script..."

SCRIPT_STATUS=0

echo "verify start..."

bash $BASH_PATH/verify/verify_code_style_script.sh || SCRIPT_STATUS=$?

if test $SCRIPT_STATUS -ne 0; then
    echo "verify error!"
    exit $SCRIPT_STATUS
fi

bash $BASH_PATH/verify/verify_license_script.sh || SCRIPT_STATUS=$?

if test $SCRIPT_STATUS -ne 0; then
    echo "verify error!"
    exit $SCRIPT_STATUS
fi

bash $BASH_PATH/verify/verify_readme_script.sh || SCRIPT_STATUS=$?

if test $SCRIPT_STATUS -ne 0; then
    echo "verify error!"
    exit $SCRIPT_STATUS
fi

bash $BASH_PATH/verify/verify_service_script.sh || SCRIPT_STATUS=$?

if test $SCRIPT_STATUS -ne 0; then
    echo "verify error!"
    exit $SCRIPT_STATUS
fi

echo "verify finish success"

exit 0
