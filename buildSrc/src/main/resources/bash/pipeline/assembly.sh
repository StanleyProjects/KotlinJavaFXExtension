echo "assembly..."

SCRIPT_STATUS=0

ASSEMBLY_PATH=/assembly
mkdir -p $ASSEMBLY_PATH

name=$(gradle -q versionName) || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
  echo "assembly summary version name error!"
  exit 1
fi
echo "Version name $name"

code=$(gradle -q versionCode) || SCRIPT_STATUS=$?
if test $SCRIPT_STATUS -ne 0; then
  echo "assembly summary version code error!"
  exit 2
fi
echo "Version code $code"

echo "\
versionName=$name
versionCode=$code\
" > $ASSEMBLY_PATH/summary

echo "assembly finish success"

exit 0
