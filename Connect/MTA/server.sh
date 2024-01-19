if [ "${EXTERNAL_RESOURCES}" ]; then
    echo "🟡   Resource Externa está habilitado, verificando conexão com o resource externo."

    resource_url=$(echo "${EXTERNAL_RESOURCES}" | sed 's/^https\?:\/\///')

    # Executa o comando ping e verifica o status
    if ping -c 1 "${resource_url}" &>/dev/null; then
        echo "✅   Conexão com o recurso externo bem-sucedida. instalando resources"
        find mods -type f -exec sed -i "s|<httpdownloadurl>\\(.*\\)</httpdownloadurl>|<httpdownloadurl>${EXTERNAL_RESOURCES}</httpdownloadurl>|g" {} +
    else
        echo "🔴   Falha na conexão com o recurso externo, verifique o servidor do mta external ou remova ele das configurações para iniciar o servidor."
        exit 0
    fi
else
    echo "🟡   Resource Externa está desabilitada, configurando para resource interna."

    find mods -type f -exec sed -i 's|<httpdownloadurl>\(.*\)</httpdownloadurl>|<httpdownloadurl></httpdownloadurl>|g' {} +
fi

./mta-server64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${SERVER_WEBPORT} -n
