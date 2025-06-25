#!/bin/bash

# Euro Truck Simulator 2
ETS_PATH=".local/share/Euro Truck Simulator 2/server_config.sii"
ETS_EXEC="./bin/linux_x64/eurotrucks2_server"
ETS_APPID="1948160"

# American Truck Simulator
ATS_PATH=".local/share/American Truck Simulator/server_config.sii"
ATS_EXEC="./bin/linux_x64/amtrucks_server"
ATS_APPID="2239530"

if [ "$SRCDS_APPID" == "$ATS_APPID" ]; then
    OUTFILE="$ATS_PATH"
    EXEC_FILE="$ATS_EXEC"
    echo "[+] Configurando para American Truck Simulator (ATS)..."
elif [ "$SRCDS_APPID" == "$ETS_APPID" ]; then
    OUTFILE="$ETS_PATH"
    EXEC_FILE="$ETS_EXEC"
    echo "[+] Configurando para Euro Truck Simulator 2 (ETS2)..."
else
    OUTFILE="$ETS_PATH"
    EXEC_FILE="$ETS_EXEC"
    echo "[+] Failback para Euro Truck Simulator 2 (ETS2)..."
    exit 1
fi

if [ ! -f "$OUTFILE" ]; then
    echo "[ERRO] Arquivo de configuração '$OUTFILE' não encontrado."
    exit 1
fi

if [ -n "$MODERATORS" ]; then
    IFS=',' read -r -a moderator_array <<< "$MODERATORS"
    moderator_count=${#moderator_array[@]}

    if [ "$moderator_count" -gt 0 ]; then
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

        echo "[+] Arquivo de configuração atualizado. Adicionados $moderator_count moderadores."
    else
        echo "[!] Variável MODERATORS está vazia. Nenhum moderador foi adicionado."
    fi
else
    echo "[!] Variável MODERATORS não definida. Pulando a atualização de moderadores."
fi


echo "[+] Iniciando o servidor do jogo..."
exec "$EXEC_FILE" "$@"
