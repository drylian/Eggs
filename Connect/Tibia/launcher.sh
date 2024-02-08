#!/bin/bash

# System Resources
if [[ ! -d "/home/container/system" || ! -f "/home/container/system/nginx/nginx.conf" || ! -f "/home/container/system/php-fpm/php-fpm.conf"  ]]; then 
    rm -rf ./system
    echo "Cloning nginx and PHP repository..."
    git clone https://github.com/drylian/nginx ./temp
    cp -r ./temp/system /home/container/
    rm -rf ./temp
    echo "Creating necessary directories..."
    mkdir /home/container/system/tmp
    mkdir /home/container/system/logs
fi

# Tibia Resources
if [[ ! -f "/home/container/tibia/tfs" ]]; then 
    echo "Downloading and extracting Tibia server..."
    GITHUB_PACKAGE=otland/forgottenserver
    MATCH=ubuntu-gcc.tar.gz

    if [ -z ${DOWNLOAD_LINK} ]; then
        echo "Fetching download link for Tibia server..."
        LATEST_JSON=$(curl --silent "https://api.github.com/repos/${GITHUB_PACKAGE}/releases/latest")
        RELEASES=$(curl --silent "https://api.github.com/repos/${GITHUB_PACKAGE}/releases")

        if [ -z "${VERSION}" ] || [ "${VERSION}" == "latest" ]; then
            DOWNLOAD_LINK=$(echo ${LATEST_JSON} | jq -r '.assets | .[].browser_download_url' | grep -i ${MATCH})
        else
            VERSION_CHECK=$(echo ${RELEASES} | jq -r --arg VERSION "${VERSION}" '.[] | select(.tag_name==$VERSION) | .tag_name')
            if [ "${VERSION}" == "${VERSION_CHECK}" ]; then
                DOWNLOAD_LINK=$(echo ${RELEASES} | jq -r --arg VERSION "${VERSION}" '.[] | select(.tag_name==$VERSION) | .assets[].browser_download_url' | grep -i ${MATCH})
            else
                echo -e "Defaulting to latest release"
                DOWNLOAD_LINK=$(echo ${LATEST_JSON} | jq .assets | jq -r .[].browser_download_url)
            fi
        fi
    else
        echo "Checking supplied download link..."
        if curl --output /dev/null --silent --head --fail ${DOWNLOAD_LINK}; then
            echo "Download link is valid. Setting download link to ${DOWNLOAD_LINK}"
        else
            echo "Download link is invalid. Exiting..."
            exit 2
        fi
    fi

    echo "Downloading Tibia server from: ${DOWNLOAD_LINK}"
    wget -O tibia.tar.gz ${DOWNLOAD_LINK}
    mkdir ./tibia
    mv tibia.tar.gz ./tibia/tibia.tar.gz
    tar -xzvf ./tibia/tibia.tar.gz
    mv -f ./forgottenserver/* ./tibia/
    rm -r ./forgottenserver
    rm -r ./tibia/tibia.tar.gz
    cp ./tibia/config.lua.dist ./tibia/config.lua
fi

# MyAAC Resources
if [[ ! -d "/home/container/website" ]]; then 
    echo "Downloading and extracting MyAAC..."
    MYAAC_JSON=$(curl --silent "https://api.github.com/repos/slawkens/myaac/releases/latest")
    MYAAC_DOWNLOAD_LINK=$(echo "${MYAAC_JSON}" | jq -r '.assets | .[].browser_download_url' | grep -i '\.zip')

    echo "Downloading MyAAC from: ${MYAAC_DOWNLOAD_LINK}"
    wget -O myaac.zip ${MYAAC_DOWNLOAD_LINK}
    unzip -d ./website myaac.zip 
    mv ./website/myaac-*/* ./website/
    rm -r ./website/myaac-*
    rm -r ./myaac.zip
fi
C3=$(echo -en "\e[1m\u001b[31m") # Cor Vermelho Com Negrito.

# StartUP Configurations
echo "
    ${C3}.-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-.
    ${C3}|   É NECESSARIO CONFIGURAR UM BANCO DE DADOS NO CONFIG.LUA EM '/tibia' E COLOCAR O SCHEMA.SQL.  |
    ${C3}|                MIGRAR O SCHEMA.SQL PARA PODER CONFIGURAR O SITE E O TFS INICIAR                |
    ${C3}*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.* 
    ${C0}
    "

echo "Setting permission..."
chmod 777 ./*
echo "Cleaning tmp files..."
rm -rf /home/container/system/tmp/*

echo "Running ip auto detect..."
ipAddress=$(curl -s https://ifconfig.me/ip)
ipAddress=$(echo $ipAddress | tr -d '[:space:]')

echo "Starting PHP-FPM..."
nohup /usr/sbin/php-fpm8.1 --fpm-config /home/container/system/php-fpm/php-fpm.conf --daemonize >/dev/null 2>&1 &
echo "PHP-FPM started successfully."

echo "Starting Nginx... running in http://${ipAddress}:${NGINX_PORT}"
nohup /usr/sbin/nginx -c /home/container/system/nginx/nginx.conf -p /home/container/ >/dev/null 2>&1 &
echo "Nginx started successfully."

cd ./tibia
./tfs
