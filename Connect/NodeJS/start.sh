echo "Iniciando node js"
if [[ -f "./package.json" ]]; then
    echo "Package Encontrada iniciando npm install automatico"
    npm install
fi

if [ "$NODE_MODE" == "Node JS" ]; then
    echo "Iniciando node com js node ${MAIN_FILE} -- -port ${SERVER_PORT} ${NODE_ARGS}"
    echo "Servidor Iniciado com Sucesso"
    node ${MAIN_FILE} -- -port ${SERVER_PORT} ${NODE_ARGS}
elif [ "${NODE_MODE}" == "Node TS" ]; then
    echo "Iniciando node com ts, verificando se é possivel usar o ts-node"
    if ! [[ -f "./package.json" ]]; then
        echo "Para usar Typescript no node é necessario o ts-node, baixado no package.json, que não pode ser encontrado em seu sistema"
        exit
    fi
    echo "Baixando ts-node por padrão"
    npm i ts-node
    echo "Iniciando typescript com ts-node ${MAIN_FILE} -- -port ${SERVER_PORT} ${NODE_ARGS}"
    echo "Servidor Iniciado com Sucesso"
    npx ts-node ${MAIN_FILE} -- -port ${SERVER_PORT} ${NODE_ARGS}
elif [ "${NODE_MODE}" == "Npm Install" ]; then
    echo "Iniciando npm install programado"
    npm install ${MAIN_FILE}
    echo "Instalação finalizada" 
else
    echo "Iniciando usando scripts da package"
    if ! [[ -f "./package.json" ]]; then
        echo "Para usar com npm scripts é necessario ter uma package.json!"
        exit
    fi
    echo "Iniciando usando o script ${MAIN_FILE}"
    echo "Servidor Iniciado com Sucesso"
    npm run ${MAIN_FILE} -- -port ${SERVER_PORT} ${NODE_ARGS}
fi
