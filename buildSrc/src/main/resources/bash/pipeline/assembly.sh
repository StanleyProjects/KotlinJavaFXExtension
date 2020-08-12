echo "assembly..."

SCRIPT_STATUS=0

ASSEMBLY_PATH=/assembly
mkdir -p $ASSEMBLY_PATH

name=$(gradle -q versionName) || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
  echo "assembly summary version name error!"; exit 11
fi
echo "Version name $name"

code=$(gradle -q versionCode) || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
  echo "assembly summary version code error!"; exit 12
fi
echo "Version code $code"

applicationId=$(gradle -q applicationId) || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
  echo "assembly summary application id error!"; exit 13
fi
echo "Application id $applicationId"

echo "\
versionName=$name
versionCode=$code
applicationId=$applicationId\
" > $ASSEMBLY_PATH/summary

gradle -q clean assembleSnapshot || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
    echo "assembly snapshot error!"; exit 21
fi
fileName=${applicationId}-${name}-${code}-snapshot.jar
resultPath=$ASSEMBLY_PATH/build/snapshot
mkdir -p $resultPath
mv lib/build/libs/$fileName $resultPath

echo "assembly finish success"

exit 0
