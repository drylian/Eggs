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
if [ "${Arquitetura}" == "arm64" ]; then 
      echo -n "${bold}${lightgreen}==> Arquitetura :Arm64x                                                    <="
   else
      echo -n "${bold}${lightgreen}==> Arquitetura :AMD64x                                                    <="
   fi
   echo "${bold}${lightgreen}="
   echo "${bold}${lightgreen}=============================================================================="
   # Inicio do COdigo
   if [[ -f "./steamcmd/steamcmd.sh" ]]; then
      echo "${bold}${lightgreen}==> A Steam Cmd foi detectada, Download não será necessario."
      ./steamcmd/steamcmd.sh +force_install_dir /home/container/ +login anonymous +app_update 90 +app_set_config 90 mod cstrike +quit
   else
      echo "${bold}${lightgreen}==> A Steam Cmd ${bold}${vermelho}Não Detectada${bold}${lightgreen}, O Sistema de download será iniciado."
      curl -sSL -o steamcmd.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz
      "${bold}${lightgreen}==> O Download foi Terminado Criando Diretorio Steamcmd."
      mkdir ./steamcmd
      "${bold}${lightgreen}Copiando e deletando arquivos desnecessarios."
      cp steamcmd.tar.gz ./steamcmd/
      rm -r ./steamcmd.tar.gz
      "${bold}${lightgreen}Iniciando extração de arquivos."
      tar -xzvf ./steamcmd/steamcmd.tar.gz ./steamcmd/
      "${bold}${lightgreen}Extração de arquivos Terminada."
   fi
done
      
