if [ "${EXTERNAL_RESOURCES}" ]; then
    echo "🟡   Resource Externa está habilitado, verificando conexão com o resource externo."

    resource_url=$(echo "${EXTERNAL_RESOURCES}" | sed 's/^https\?:\/\///')

    # Executa o comando ping e verifica o status
    if ping -c 1 "${resource_url}" &>/dev/null; then
        echo "✅   Conexão com o recurso externo bem-sucedida."
    else
        echo "🔴   Falha na conexão com o recurso externo, verifique o servidor do mta external ou remova ele das configurações para inciar o servidor."
        exit 0
    fi
fi

./mta-server64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${SERVER_WEBPORT} -n
