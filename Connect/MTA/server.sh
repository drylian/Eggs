#!/bin/bash

# Definindo permissões recursivas
chmod -R 777 ./*

if [[ -f "./mta-accelerator" ]]; then
    echo "Acelerador encontrado, iniciando."
else
    echo "Acelerador não encontrado, baixando."
    # Baixando o httpserver se não estiver presente
    curl -L -o /home/container/mta-accelerator "https://github.com/drylian/Eggs/releases/download/1.0.0/mta-accelerator"
fi
chmod 777 mta-accelerator

nohup ./mta-accelerator --trace-warnings true --express ${EXPRESS_PORT} > meu_accelerator.log &
./mta-server64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${HTTP_PORT} -n