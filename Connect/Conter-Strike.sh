#!/bin/bash

Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "amd64" || echo "arm64")
# Cores do Sistema 
bold=$(echo -en "\e[1m")
lightgreen=$(echo -en "\e[92m")
vermelho=$(echo -en "\e[31m")
# ${bold}${vermelho}
   echo "${bold}${lightgreen}=============================================================================="
   echo "${bold}${lightgreen}==>                      Sistema De Suporte Iniciado.                      <=="
   echo "${bold}${lightgreen}==>                                                                        <=="
# if do samp03svr
if [ "${Arquitetura}" == "arm64" ]; then 
      echo -n "${bold}${lightgreen}==> Arquitetura :Arm64x                                                    <="
   else
      echo -n "${bold}${lightgreen}==> Arquitetura :AMD64x                                                    <="
   fi
   echo "${bold}${lightgreen}="
   echo "${bold}${lightgreen}=============================================================================="
   # Inicio do COdigo
   curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
   mkdir -p ./steamcmd
   tar -xzvf steamcmd.tar.gz -C ./steamcmd
   echo "${bold}${lightgreen}Teste de egg"
   ./steamcmd/steamcmd.sh +force_install_dir ./ +login anonymous +app_update 90 +app_set_config 90 mod cstrike +quit
   mkdir -p ./.steam/sdk32
   cp -v linux32/steamclient.so ../.steam/sdk32/steamclient.so
   ## install end
echo "-----------------------------------------"
echo "Installation completed..."
echo "-----------------------------------------"
