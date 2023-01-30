#!/bin/ash

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
   
   # inicio codigo
   echo "${bold}${lightgreen}==> Iniciando Sistema."
   echo "${bold}${lightgreen}==> Iniciando Verificando Arquivos."
   
   # download nginx-explorer
   if [[ -f "./site/assets/explorer_instalado" ]]; then
      echo "${bold}${lightgreen}==> Nginx Explorer foi detectado, pulando Download."
   else
      echo "${bold}${lightgreen}==> Nginx Explorer ${bold}${vermelho}não foi detectado ${bold}${lightgreen}, Iniciando download"
      mkdir ./site
       git clone https://github.com/drylian/nginx-explorer ./site
       touch ./site/assets/explorer_instalado
   fi
   
   echo "${bold}${lightgreen}==> Verificando Arquivos."
   
   if [ ! -d "./logs/" ]; then
   echo "${bold}${lightgreen}==> Executando procedimento padrão das Logs."
   mkdir ./tempp
   mv ./logs/* ./tempp
   rm -df ./logs
   else
   echo "${bold}${lightgreen}==> Criando Logs iniciais."
   fi
   
   echo "${bold}${lightgreen}==> Iniciando Procedimentos padrão da logs."
   mkdir logs >/dev/null
   
   echo "${bold}${lightgreen}==> Verificando Arquivos."
   
   # download default.conf
   if [[ -f "./site/assets/nginx_instalado" ]]; then
   echo "${bold}${lightgreen}==> Default.conf ja carregado, pulando etapa."
   else
   echo "${bold}${lightgreen}==> Iniciando configurações Iniciais."
   rm ./nginx/conf.d/default.conf
   curl https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/default.conf -o ./nginx/conf.d/default.conf
   touch ./site/assets/nginx_instalado
   touch ./site/files/exemplo
   fi
   
   echo "${bold}${lightgreen}==> Verificação Completa."
   echo "${bold}${lightgreen}==> Setando permissções padrões."
   chmod 777 ./*
   # iniciando sistema 
   echo "${bold}${lightgreen}==> Iniciando Sistema "
  
   echo "${bold}${lightgreen}==> Removendo Arquivos Temporarios "
   rm -rf /home/container/tmp/*
   rm -f ./start.sh
   
   echo "${bold}${lightgreen}==> Removendo Arquivos Temporarios "
   echo "${bold}${lightgreen}==> Versão do script: 1.0 "
   
   echo "${bold}${lightgreen}==> Iniciando PHP-FPM "   
   /usr/sbin/php-fpm8 --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize
   
   if [[ -f "./site/assets/instalacao_completa" ]]; then
   else
   echo "${bold}${lightgreen}==> ✅ Reiniciando Instalador para Finalização."
   touch ./site/assets/instalacao_completa
   curl https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/start.sh ./start.sh; 
   chmod 777 ./*; 
   sh ./start.sh
   fi
   
   echo "${bold}${lightgreen}==> Iniciando Nginx "
   echo "${bold}${lightgreen}==> ✅ Inicializado com sucesso"
   echo "${bold}${lightgreen}==> ✅ Finalizando iniciador online"
   /usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/
