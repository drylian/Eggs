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
      echo -n "${bold}${lightgreen}==> Arquitetura :Arm64x (Usa Emulação box86)                               <="
   else
      echo -n "${bold}${lightgreen}==> Arquitetura :AMD64x (Executando em 86X)                                <="
   fi
   echo "${bold}${lightgreen}="
   echo "${bold}${lightgreen}=============================================================================="
# Samp03svr verificado
if [[ -f "./samp03svr" ]]; then
   echo "${bold}${lightgreen}==> O Samp Linux foi detectado, O Sistema de download não será necessario. <=="
   # Samp-NPC verificado
   if [[ -f "./samp-npc" ]]; then
      echo "${bold}${lightgreen}==> O Samp Npc foi detectado, O Sistema de download não será necessario.   <=="
      else 
      echo "${bold}${lightgreen}==> O Samp Npc ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      curl -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
   fi
   # Samp-NPC Fim
   # Announce verificado
   if [[ -f "./announce" ]]; then
      echo "${bold}${lightgreen}==> O Announce foi detectado, O Sistema de download não será necessario.   <=="
      else
      echo "${bold}${lightgreen}==> O Announce ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      curl -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
   fi
   # Announce Fim
      echo "${bold}${lightgreen}==> Setando permissões padrões.                                            <=="
      # Permissões-------------
      chmod 777 samp03svr    #-
      chmod 777 samp-npc     #-
      chmod 777 announce     #-
      chmod -R 777 ./*       #-
      #------------------------
      echo "${bold}${lightgreen}==> Permissões Setadas, Iniciando nova Server_log.txt.                     <=="
      # if da pasta Logs
      if [[ -f "./Logs_Do_Servidor/Log_Completa_do_servidor.txt" ]]; then
         echo "${bold}${lightgreen}==> Pasta de Logs encontrada, Copiando Server_log.txt.                     <=="
      else 
         echo "${bold}${lightgreen}==> Pasta de Logs ${bold}${vermelho}não encontrada${bold}${lightgreen}, criando uma nova.                        <=="
         mkdir ./Logs_Do_Servidor/
   fi
   # if da Server_log.txt
      if [[ -f "./server_log.txt" ]]; then
         echo "${bold}${lightgreen}==> Copiando Server_log.txt para a Log Completa.                           <=="
         cat ./server_log.txt >> ./Logs_Do_Servidor/Log_Completa_do_servidor.txt
         echo "${bold}${lightgreen}==> Deletando antiga Server_log.txt.                                       <=="
         rm server_log.txt
      else
         echo "${bold}${lightgreen}==> Server_log.txt ${bold}${vermelho}não encontrada${bold}${lightgreen}, pulando etapa.                          <=="
      fi
   echo "${bold}${lightgreen}==> Iniciando Servidor.                                                    <=="
   echo "${bold}${lightgreen}=============================================================================="
   # Comando de Iniciação do Servidor-----------------------------------------------------------------------------
   $(if [ "${Arquitetura}" == "arm64" ]; then echo -n "box86 ./samp03svr"; else echo -n "./samp03svr"; fi)      #-
   # Comando de Iniciação do Servidor-----------------------------------------------------------------------------

else
# Samp03svr download
   echo "${bold}${lightgreen}==> O Samp Linux ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.       <=="
   curl -L -o /home/container/samp03svr "https://github.com/drylian/Eggs/releases/latest/download/samp03svr"
   # Samp03svr download
   echo "${bold}${lightgreen}==> Download Terminado, iniciando configurações padrões.                   <=="
   # Samp-NPC verificado
   if [[ -f "./samp-npc" ]]; then
      echo "${bold}${lightgreen}==> O Samp Npc foi detectado, O Sistema de download não será necessario.   <=="
      else 
      echo "${bold}${lightgreen}==> O Samp Npc ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      curl -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
   fi
   # Samp-NPC Fim
   # Announce verificado
      if [[ -f "./announce" ]]; then
      echo "${bold}${lightgreen}==> O Announce foi detectado, O Sistema de download não será necessario.   <=="
      else
      echo "${bold}${lightgreen}==> O Announce ${bold}${vermelho}Não Detectado${bold}${lightgreen}, O Sistema de download será iniciado.         <=="
      curl -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
      fi
   # Announce Fim
   echo "${bold}${lightgreen}==> Setando permissões padrões.                                            <=="
   # Permissões-------------
   chmod 777 samp03svr    #-
   chmod 777 samp-npc     #-
   chmod 777 announce     #-
   chmod -R 777 ./*       #-
   #------------------------
   echo "${bold}${lightgreen}==> Permissões Setadas, Iniciando nova Server_log.txt.                     <=="
      if [[ -f "./Logs_Do_Servidor/Log_Completa_do_servidor.txt" ]]; then
         echo "${bold}${lightgreen}==> Pasta de Logs encontrada, Copiando Server_log.txt.                     <=="
      else
         echo "${bold}${lightgreen}==> Pasta de Logs ${bold}${vermelho}não encontrada${bold}${lightgreen}, criando uma nova.                        <=="
         mkdir ./Logs_Do_Servidor/
   fi
      if [[ -f "./server_log.txt" ]]; then
         echo "${bold}${lightgreen}==> Copiando Server_log.txt para a Log Completa.                           <=="
         cat ./server_log.txt >> ./Logs_Do_Servidor/Log_Completa_do_servidor.txt
         echo "${bold}${lightgreen}==> Deletando antiga Server_log.txt.                                       <=="
         rm server_log.txt
      else
         echo "${bold}${lightgreen}==> Server_log.txt ${bold}${vermelho}não encontrada${bold}${lightgreen}, pulando etapa.                          <=="
   fi
   echo "${bold}${lightgreen}==> Iniciando Servidor.                                                    <=="
   echo "${bold}${lightgreen}=============================================================================="
   # Comando de Iniciação do Servidor-----------------------------------------------------------------------------
   $(if [ "${Arquitetura}" == "arm64" ]; then echo -n "box86 ./samp03svr"; else echo -n "./samp03svr"; fi)      #-
   # Comando de Iniciação do Servidor-----------------------------------------------------------------------------
fi
# Samp03svr Fim
echo "${bold}${lightgreen}==> ${bold}${vermelho}O Samp encontrou um erro e não iniciou, verifique o server_log.txt. ${bold}${lightgreen}<=="
echo "${bold}${lightgreen}=============================================================================="
