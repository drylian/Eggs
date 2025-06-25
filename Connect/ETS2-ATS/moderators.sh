#!/bin/bash

ETS_PATH=".local/share/Euro Truck Simulator 2/server_config.sii"
ETS="1948160" # Euro Truck Simulator 2
ATS_PATH=".local/share/American Truck Simulator/server_config.sii"
ATS="2239530" # American Truck Simulator

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

echo "Running with $moderator_count moderators."
