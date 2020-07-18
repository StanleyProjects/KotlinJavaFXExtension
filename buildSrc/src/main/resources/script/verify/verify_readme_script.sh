TYPE="Readme"
echo "verify $TYPE script..."

SCRIPT_STATUS=0

echo "verify $TYPE start..."
timeStart=$(date +%s)
gradle -q clean verify$TYPE || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
    echo "verify $TYPE error!"
    exit $SCRIPT_STATUS
fi
echo "\
verify $TYPE success $(($(date +%s)-timeStart)) sec\
"

exit 0
