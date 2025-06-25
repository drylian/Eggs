#!/bin/bash

# Euro Truck Simulator 2
ETS_PATH=".local/share/Euro Truck Simulator 2/server_config.sii"
ETS_EXEC="./bin/linux_x64/eurotrucks2_server"
ETS="1948160"

# American Truck Simulator
ATS_PATH=".local/share/American Truck Simulator/server_config.sii"
ATS_EXEC="./bin/linux_x64/amtrucks_server"
ATS="2239530"

OUTFILE=$([ "$SRCDS_APPID" == "$ATS" ] && echo "$ATS_PATH" || echo "$ETS_PATH")

if [ ! -f "$OUTFILE" ]; then
    echo "Erro: Arquivo '$OUTFILE' não encontrado."
    exit 1
fi

IFS=',' read -r -a moderator_array <<< "$MODERATORS"

moderator_count=${#moderator_array[@]}

new_moderator_lines=" moderator_list: $moderator_count"
for i in "${!moderator_array[@]}"; do
    new_moderator_lines+="\\n moderator_list[$i]: ${moderator_array[$i]}"
done

awk -v new_lines="$new_moderator_lines" '
    /moderator_list/ { next }
    /}/ && in_server_config {
        print new_lines;
        in_server_config=0;
    }
    /server_config :/ { in_server_config=1 }
    { print }
' "$OUTFILE" > "${OUTFILE}.tmp" && mv "${OUTFILE}.tmp" "$OUTFILE"

echo "[+] Added $moderator_count moderators."
