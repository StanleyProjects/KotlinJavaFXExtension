echo "telegram send message..."

if test $# -ne 1; then
    echo "Script needs for 1 arguments but actual $#"
    exit 1
fi

TELEGRAM_BOT_ID=${telegram_bot_id:?"Variable \"telegram_bot_id\" is not set"}
TELEGRAM_BOT_TOKEN=${telegram_bot_token:?"Variable \"telegram_bot_token\" is not set"}
TELEGRAM_CHAT_ID=${telegram_chat_id:?"Variable \"telegram_chat_id\" is not set"}
MESSAGE=$1

url="https://api.telegram.org/bot$TELEGRAM_BOT_ID:$TELEGRAM_BOT_TOKEN/sendMessage"

MESSAGE=${MESSAGE//"#"/"%23"}
MESSAGE=${MESSAGE//$'\n'/"%0A"}
MESSAGE=${MESSAGE//$'\r'/""}

code=$(curl -w '%{http_code}\n' -G \
    -o /dev/null \
    -s $url \
    -d chat_id=$TELEGRAM_CHAT_ID \
    -d text="$MESSAGE" \
    -d parse_mode=markdown)

if test $code -ne 200; then
    echo "Request error with response code $code!"
    exit 2
fi

echo "message: $MESSAGE sent by telegram bot"
