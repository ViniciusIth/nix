counter=1

texts=(
    "Hello world"
    "Random message"
    "Testing notifications"
    "QML is fun"
    "You're doing great"
    "Here's another popup"
    "The counter keeps going"
    "Heres a reeeeeeeeeeeeeeeeeeeeeeeeeeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally long line"
)

while true; do
    rand_index=$(( RANDOM % ${#texts[@]} ));
    random_text="${texts[$rand_index]}";
    notify-send
        --action=ok:OK \
        --action=cancel:Cancel \
        "Message #$counter" \
        "$random_text" &

    counter=$(( counter + 1 ));
    sleep 1; 
done
