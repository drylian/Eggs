#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Setting recursive permissions
chmod -R 777 ./*

if [[ -f "./accelerator-update" ]]; then
    echo -e "${YELLOW}Setting up the accelerator, updating.${NC}"
    rm -r ./accelerator
    mv ./accelerator-update ./accelerator
fi

if [[ -f "./accelerator" ]]; then
    echo -e "${GREEN}Accelerator found, starting.${NC}"
else
    echo -e "${RED}Accelerator not found, downloading.${NC}"
    # Downloading the accelerator if not present
    curl -L -o /home/container/accelerator "https://github.com/drylian/Accelerator/raw/main/release/accelerator-rs"
fi

chmod 777 accelerator

# Update Server Name
if [ -z "${SERVER_NAME}" ]; then
    SERVER_NAME="Default MTA Server"
fi
find mods -type f -exec sed -i "s|<servername>\(.*\)</servername>|<servername>${SERVER_NAME}</servername>|g" {} +

nohup ./accelerator --accelerator ${EXPRESS_PORT} >accelerator.log 2>accelerator_error.log &

echo -e "${GREEN}Accelerator has been started successfully. Check the logs in (accelerator.log and accelerator_error.log).${NC}"

./mta-server64 --maxplayers ${MAX_PLAYERS} --port ${SERVER_PORT} --httpport ${HTTP_PORT} -n
