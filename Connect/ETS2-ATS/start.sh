#!/bin/bash

# Euro Truck Simulator 2
ETS_PATH="${HOME}/.local/share/Euro Truck Simulator 2/server_config.sii"
ETS_EXEC="./bin/linux_x64/eurotrucks2_server"
ETS_APPID="1948160"

# American Truck Simulator
ATS_PATH="${HOME}/.local/share/American Truck Simulator/server_config.sii"
ATS_EXEC="./bin/linux_x64/amtrucks_server"
ATS_APPID="2239530"

# --- Lógica de seleção do jogo ---
if [ "$SRCDS_APPID" == "$ATS_APPID" ]; then
    OUTFILE="$ATS_PATH"
    EXEC_FILE="$ATS_EXEC"
    echo "[+] Configurando para American Truck Simulator (ATS)..."
elif [ "$SRCDS_APPID" == "$ETS_APPID" ]; then
    OUTFILE="$ETS_PATH"
    EXEC_FILE="$ETS_EXEC"
    echo "[+] Configurando para Euro Truck Simulator 2 (ETS2)..."
else
    # Se nenhuma variável for definida, assume ETS2 como padrão
    OUTFILE="$ETS_PATH"
    EXEC_FILE="$ETS_EXEC"
    echo "[!] SRCDS_APPID não definido. Usando como padrão Euro Truck Simulator 2 (ETS2)..."
fi

if [ ! -f "$OUTFILE" ]; then
    echo "[ERRO] Arquivo de configuração '$OUTFILE' não encontrado."
    exit 1
fi

# --- Lógica de atualização dos moderadores ---
if [ -n "$MODERATORS" ]; then
    # Converte a string de moderadores (separada por vírgulas) em um array
    IFS=',' read -r -a moderator_array <<< "$MODERATORS"
    moderator_count=${#moderator_array[@]}

    # Cria um arquivo temporário para a saída do awk
    TMP_FILE=$(mktemp)

    # awk para remover linhas antigas e inserir as novas
    awk -v count="$moderator_count" -v mods="$MODERATORS" '
        BEGIN {
            # Divide a string de moderadores em um array
            split(mods, id_array, ",")
        }
        # Esta regra se aplica a todas as linhas entre "server_config :" e "}"
        /^[[:space:]]*server_config :/,/^[[:space:]]*}/ {
            # Se a linha atual for uma entrada de moderador antiga, pule-a (não a imprima)
            if (/^[[:space:]]*moderator_list/) {
                next
            }
            # Se a linha for o "}" de fechamento E ainda não processamos os moderadores
            if (/^[[:space:]]*}/ && !processed) {
                # Se houver moderadores para adicionar
                if (count > 0) {
                    print " moderator_list: " count
                    # Imprime os moderadores em ordem crescente (0, 1, 2, ...)
                    for (i = 0; i < count; i++) {
                        print " moderator_list[" i "]: " id_array[i+1]
                    }
                } else {
                    # Se não houver moderadores, apenas zere a contagem
                    print " moderator_list: 0"
                }
                processed = 1 # Marca como processado para não repetir
            }
        }
        # Imprime a linha atual (se não foi pulada pelo "next")
        { print }
    ' "$OUTFILE" > "$TMP_FILE"

    # Substitui o arquivo original pelo temporário se o awk funcionou
    if [ $? -eq 0 ]; then
        mv "$TMP_FILE" "$OUTFILE"
        echo "[+] Lista de moderadores atualizada com sucesso para $moderator_count moderador(es)."
    else
        echo "[ERRO] Falha ao atualizar o arquivo de configuração com awk."
        rm -f "$TMP_FILE"
        exit 1
    fi

else
    echo "[!] Variável MODERATORS não definida. Pulando a atualização de moderadores."
fi

# --- Inicia o servidor ---
echo "[+] Iniciando o servidor do jogo..."
exec "$EXEC_FILE" "$@"
