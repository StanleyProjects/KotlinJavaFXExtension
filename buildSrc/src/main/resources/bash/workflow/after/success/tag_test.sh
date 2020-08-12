echo "tag test..."

REF=refs/tags/$TAG_NAME

rm -f file
code=$(curl -w %{http_code} -o file \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/git/$REF)
if test $code -eq 404; then
    echo "Tag $TAG_NAME doesn't exist yet."; return 0
elif test $code -ne 200; then
    echo "Request error with response code $code!"; return 1
fi
body=$(<file);rm file

ref=$(echo $body | jq -r .ref 2>/dev/null)
if test "$ref" == $REF; then
    echo "Tag $TAG_NAME already exists!"; return 2
fi

ref=$(echo $body | jq -r ".[] | select(.ref == \"$REF\") | .ref")
if test "$ref" == $REF; then
    echo "Tag $TAG_NAME already exists!"; return 3
fi

echo "Tag $TAG_NAME doesn't exist yet."; return 0