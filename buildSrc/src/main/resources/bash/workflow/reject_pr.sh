echo "accept pr #$PR_NUMBER..."

if test -z $github_pat; then
    echo "GitHub personal access token must be exists!"
    return 1
fi

json="{\"state\":\"closed\"}"

code=$(curl -w %{http_code} -o /dev/null -X PATCH \
    -s https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/pulls/$PR_NUMBER \
    -H "Authorization: token $github_pat" \
    -d "$json")

if test $code -ne 200; then
    echo "Pull request #$PR_NUMBER rejecting error!"
    echo "Request error with response code $code!"
    return 2
fi
