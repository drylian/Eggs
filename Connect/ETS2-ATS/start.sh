#!/bin/bash

# Euro Truck Simulator 2
ETS_PATH=".local/share/Euro Truck Simulator 2/server_config.sii"
ETS_EXEC="./bin/linux_x64/eurotrucks2_server"
ETS_APPID="1948160"

# American Truck Simulator
ATS_PATH=".local/share/American Truck Simulator/server_config.sii"
ATS_EXEC="./bin/linux_x64/amtrucks_server"
ATS_APPID="2239530"

# --- CONFIGURAÇÃO DO JOGO ---
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
    echo "[!] Falha na detecção do APPID. Usando Euro Truck Simulator 2 (ETS2) como padrão."
fi

if [ ! -f "$OUTFILE" ]; then
    echo "[ERRO] Arquivo de configuração '$OUTFILE' não encontrado."
    exit 1
fi

# --- ATUALIZAÇÃO DA LISTA DE MODERADORES ---
if [ -n "$MODERATORS" ]; then
    IFS=',' read -r -a moderator_array <<< "$MODERATORS"
    moderator_count=${#moderator_array[@]}

    # Cria as novas linhas de moderadores com a indentação correta (1 espaço)
    if [ "$moderator_count" -gt 0 ]; then
        new_moderator_lines=" moderator_list: $moderator_count"
        for i in "${!moderator_array[@]}"; do
            new_moderator_lines+="\\n moderator_list[$i]: ${moderator_array[$i]}"
        done
    else
        # Se a lista de moderadores estiver vazia, apenas remove o bloco
        new_moderator_lines=""
    fi

    # Remove apenas as linhas relacionadas a moderadores, preservando a estrutura
    sed -i '/^[[:space:]]*moderator_list:/d; /^[[:space:]]*moderator_list\[[0-9]\+\]:/d' "$OUTFILE"

    # Se houver novos moderadores, insere as linhas antes da chave de fechamento do bloco server_config
    if [ -n "$new_moderator_lines" ]; then
        awk -v new_lines="$new_moderator_lines" '
            # Encontra a linha com apenas "}" (fechamento do bloco server_config)
            /^[[:space:]]*}[[:space:]]*$/ && !block_found {
                # Adiciona uma quebra de linha antes de inserir os moderadores
                if (prev_line != "") {
                    print prev_line
                }
                print new_lines
                prev_line = $0
                block_found = 1
                next
            }
            {
                if (prev_line != "") {
                    print prev_line
                    prev_line = ""
                }
                print
            }
            END {
                if (prev_line != "") {
                    print prev_line
                }
            }
        ' "$OUTFILE" > "${OUTFILE}.tmp" && mv "${OUTFILE}.tmp" "$OUTFILE"
    fi
    
    echo "[+] Arquivo de configuração atualizado. Adicionados $moderator_count moderadores."
else
    echo "[!] Variável MODERATORS não definida. Pulando a atualização de moderadores."
fi

echo "[+] Iniciando o servidor do jogo..."
exec "$EXEC_FILE" "$@"
