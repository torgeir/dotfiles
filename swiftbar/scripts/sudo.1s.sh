if [[ "$1" = "toggle" ]]; then
    open -a Toggle\ Privileges
fi

is_admin=$(groups torgeir | grep -q -w admin && echo "yes" || echo "no")
if [[ "$is_admin" == "yes" ]]; then
    echo "🦸"
else
    echo "🙍‍♂️"
fi

echo "---"

echo "toggle sudo | bash='$0' param1=toggle terminal=false"
