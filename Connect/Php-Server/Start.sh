#!/bin/bash
#        ====================================================
#                 SA-MP Script Egg Criado por Drylian
#        ====================================================
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌ 📍 ✂️ 🗑️ 🟧 🟨 ⬜ 
# Icones ☑️ ✖️ ❎ 💾 📓 📗 📘 📙 📝 📖 📚 📰 🗞️ 🏷️ 🟥 🟩 🟦 ⚙️ 
# Icones 📒 📔 📕 📑 📂 📁 🗂️ 🗃️ 🗄️ 📊 📈 📉 📇 📌 🟪 🟫 ⬛    
#

# Comandos Do painel Múdaveis
if [ -z "$INICIADOR" ]; then StartType="1"; else StartType="${INICIADOR}"; fi # Define que tipo de comando vai ser executado 0=Direto 1=Nohub.
Script_Type="2" # Define se este Script é Beta ou Alpha. 1=Alpha 2=Beta.
StartAMD="./samp03svr" # Comando Start para amd.
StartARM="sh -c box86 ./samp03svr" # Comando Start para arm.
Stop_CMD="Parar Servidor" # Comando para parar o Servidor.
Permissoes_padroes="chmod 777 ./*" # Define as permissões do arquivos, por padrão recomendo chmod 777 ./*.
Egg="PHP-SERVER           " # O Nome do egg que será executado, lembrando que o numero de caracteres maximos dentro "" é 20 oque não tiver de nome, use em espaços.
Pasta_Base="📂Informações" # O Nome da pasta onde vai ser armazenada todas as informações do Script.
Base_txt="🟢Informações.txt" # Nome do Arquivo Onde vai Ficar os Verificadores do egg.
script_log="Script.log.txt" # Nome da Log que o Script vai Rodar.
debug_log="Debug.log.txt" # Nome da Log que vai rodar o Debug.
Base_Url="https://github.com/drylian/Eggs" #Link do github onde pode achar o egg.
version_file="./📂Informações/🟢Informações.txt" # Local onde a versão vai ser Armazenada.
version_remote="https://raw.githubusercontent.com/drylian/Eggs/main/Connect/SAMP/Vers%C3%A3o.txt" #Local onde a Versão Latest vai ser vista
# Cores do Terminal
C0=$(echo -en "\u001b[0m") # Padrão
C1=$(echo -en "\e[1m\u001b[36m") # Cor Ciano Com negrito.
C2=$(echo -en "\e[1m\u001b[32m") # Cor Verde Com Negrito.
C3=$(echo -en "\e[1m\u001b[31m") # Cor Vermelho Com Negrito.
C4=$(echo -en "\e[1m\u001b[34m") # Cor Azul Com Negrito.
C5=$(echo -en "\e[1m\u001b[35m") # Cor Margeta Com Negrito.
B0="\e[1m" # Negrito
# Dependencias do Script
# Criação da Pasta de Vefiricação
if [[ ! -f "./📂Informações/🟢Informações.txt" ]]; then mkdir -p ./${Pasta_Base}; echo -e "🟢Informações Do Script\n#\n🟢Criado por Drylian\n🟢Github: https://github.com/drylian/Eggs\n🟢Versão Atual: PRÉ" > ./📂Informações/🟢Informações.txt; fi # Cria a pasta e o primeiro arquivo de versão.
if [[ ! -d "${Pasta_Base}/Logs" ]]; then mkdir -p ./${Pasta_Base}/Logs; fi
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "AMD64" || echo "ARM64") # Pega a Arquitetura da maquina
if [ "${Arquitetura}" == "ARM64" ]; then StartUP_CMD="${StartARM}"; else StartUP_CMD="${StartAMD}"; fi # isto é o que de fato vai executar como StartUP_CMD
version=$(grep "🟢Versão Atual: " "$version_file" | cut -d' ' -f3) # Lendo a versão local
if [ "${version}" == "PRÉ" ]; then version2="${version}"; else version2="${version} "; fi #organiza o tamanho da versão
if [ "${SUPORTE_ATIVO}" == "1" ]; then Suporte_egg="✅ ${C1}Definido   ${C0}"; else Suporte_egg="❌ ${C3}Indefinido ${C0}"; fi # Verificação do Suporte
if [ "${AUTO_UPDATE}" == "1" ]; then Updater_egg="✅ ${C1}Definido   ${C0}"; else Updater_egg="❌ ${C3}Indefinido ${C0}"; fi # Verificação do Atualização.
if [ "${StartType}" == "0" ]; then Type_egg="✅ ${C1}Direto     ${C0}"; else Type_egg="✅ ${C1}NoHub      ${C0}"; fi # Verificação do TypeStart
if [ "${Script_Type}" == "1" ]; then Scriptstat="${C1}Alpha${C0}"; else Scriptstat="${C1}Beta ${C0}"; fi # Beta sim e não
if [ -z "${SUPORTE_ATIVO}" ]; then Suporte="❌ ${C3}Desativado ${C0}"; else Suporte="✅ ${C1}Ativado    ${C0}"; fi # Verificação do Suporte egg
if [ -z "${AUTO_UPDATE}" ]; then Updater="❌ ${C3}Desativado ${C0}"; else  Updater="✅ ${C1}Ativado    ${C0}"; fi # Verificação do Atualização egg
# Carregar Versões
version_latest=$(curl -s "$version_remote" | grep "🟢Versão Latest: " | cut -d' ' -f3) # Lendo a versão remota
if [ "$version" != "$version_latest" ]; then version_update="> ${C2}${version_latest}${C0}"; else version_update="    "; fi # Verificando se há uma nova versão disponível.
# Inicio Do Script
if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then
    echo "
    .+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-*.
    |                                          |                  ${C5}INICIANDO SCRIPT${C0}                   |
    |                   ${C5}:%${C1}*${C0}                    |+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-|
    |                  ${C5}:%${C1}@@*${C0}                   |                          |                          |
    |                 ${C5}-@${C1}@@@@#${C0}                  | ${C0}Egg:${C1} ${Egg}${C0}| Arquitetura:${C1} ${Arquitetura} ${C0}      |
    |                ${C5}=@${C1}@@@@@@%.${C0}                | Versão: ${C1}${version2}${C0} ${version_update}        | Script: ${C1}${Scriptstat}${C0}            |
    |               ${C5}+@${C1}@@@#${C5}%${C1}@@@%:${C0}               | StartType: ${Type_egg} |                          |
    |              ${C5}+@${C1}@@@= ${C5}.#${C1}@@@%:${C0}              |                          |                          |
    |             ${C5}*@${C1}@@@-    ${C5}#${C1}@@@@-${C0}             |+*-+*-+*-+*-+*-+*-+*-+*-+*|+*-+*-+*-+*-+*-+*-+*-+*-+*|
    |            ${C5}#@${C1}@@@:      ${C5}*@${C1}@@@=${C0}            |     ${C5}VARIANTES DO EGG${C0}     |   ${C5}ATIVADOS/DESATIVADOS${C0}   |
    |          ${C5}.%@${C1}@@%:        ${C5}+@${C1}@@@+${C0}           |+*-+*-+*-+*-+*-+*-+*-+*-+*|+*-+*-+*-+*-+*-+*-+*-+*-+*|
    |         ${C5}:%@${C1}@@%.          ${C5}=@${C1}@@@*${C0}          |                          |                          |
    |        ${C5}:%@${C1}@@#   ${C5}++${C1}++++++++@@@@@*${C0}         | Suporte: ${Suporte_egg}   | Suporte: ${Suporte}   |
    |       ${C5}=@${C1}@@@#  ${C5}.%@${C1}@@@@@@@@@@@@@@@%.${C0}       |                          |                          |
    |      ${C5}-%${C1}%%%#  ${C5}.+%${C1}##########%%%%%#%*.${C0}      | Update: ${Updater_egg}    | Update: ${Updater}    |
    |    ${C5} --${C1}-----  ------------------------${C0}    |                          |                          |
    |                                          |                          |                          |
    *-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*°-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.*
    " 

    if [ -z "$AUTO_UPDATE" ] || [ -z "$SUPORTE_ATIVO" ] || [ -z "$INICIADOR" ]; then
    echo "
    ${C3}.-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-.
    ${C3}|   UMA OU MAIS VARIANTES DO EGG ESTÃO EM FALTA, BAIXE A VERSÃO MAIS RECENTE DO EGG NO GITHUB.   |
    ${C3}|                                 https://github.com/drylian/Eggs                                |
    ${C3}*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.* 
    ${C0}"
    
    fi
        # Atualizações
    if [ "${AUTO_UPDATE}" == "1" ]; then
        echo " 🔵   A ${C1}Atualizações Automatica${C0} está ${C2}Ativada${C0}, Buscando Atualizações..."
        if [ "$version" == "PRÉ" ]; then
            echo " 🔵 ${C1}Versão Inicial${C0} detectada, Iniciando Downloads..."
            sed -i '/🟢Versão Atual:*/d' ./📂Informações/🟢Informações.txt
            echo  "🟢Versão Atual: ${version_latest}" >> "./📂Informações/🟢Informações.txt"
        elif [ "$version" != "$version_latest" ]; then
            echo " 🔵   Nova ${C1}Versão${C0} detectada, Iniciando Atualização..."
            # Oque vai Fazer se tiver atualização
            
            
            
            
            
            
            # Seta a versão mais atual
            sed -i '/🟢Versão Atual:*/d' ./📂Informações/🟢Informações.txt
            echo "🟢Versão Atual: ${version_latest}" >> "./📂Informações/🟢Informações.txt"
            echo " 🔵   Nova ${C1}Versão${C0} Instalada, Iniciando Downloads..."
        elif [ "$version" == "$version_latest" ]; then
            echo " 🔵   Sistema está ${C1}Atualizado${C0} versão atual ${version}..."
        fi
    else
        echo " 🟡   A ${C1}Atualizações Automatica${C0} está ${C3}Desativada${C0}, Pulando etapa..."
    fi

    echo " "

    # Aqui ficará o Script
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

    echo " "

    echo " 🔵   Setando ${C1}Permissões${C0} padrões."
    eval "$Permissoes_padroes"

    echo " "

    # Fim do Script
    echo " 🔵   ${C1}Verificação e Instalação${C0} dependecias foi terminado, Iniciando ${C1}Inicializador${C0}..."

    echo " "
    echo "Servidor Samp foi Iniciado com Sucesso."
    # O StartType do comando não necessita mudar
    if [ "${StartType}" == "1" ]; then
        echo " 🔵   Executando em modo ${C1}Nohup(Script 2.0)${C0}..."
        nohup ${StartUP_CMD} > samp.log.txt 2> samp.erro.log.txt &
        pid=$!
        # Continua a exibir as últimas linhas do arquivo de log a cada segundo
        while true; do
            tail -n 10 -F server_log.txt
            tail -n 10 -F samp.erro.log.txt
            sleep 1
            # Verifica se o processo do aplicativo ainda está ativo
            if ! kill -0 $pid 2> /dev/null; then
                # Salva as logs na pasta "./${Pasta_Base}/Logs/"./Informacoes/Informacoes.txt
                echo "🔴 ${C3}O ${Egg} foi finalizado sem aviso, provavelmente erro interno, desligando script${C0}..."
                if [ ! -f "./📂Informações/Logs/Server.log.txt" ]; then
  					echo " " > "./📂Informações/Logs/Server.log.txt"
                fi
                cat server_log.txt >> ./📂Informações/Logs/Server.log.txt

                if [ ! -f "./📂Informações/Logs/Samp.log.txt" ]; then
                    echo " " > "./📂Informações/Logs/Samp.log.txt"
                fi
                cat samp.log.txt >> ./📂Informações/Logs/Samp.log.txt

                if [ ! -f "./📂Informações/Logs/Samp.erro.log.txt" ]; then
                  	echo " " > "./📂Informações/Logs/Samp.erro.log.txt"
                fi
                if [ ! -f "./📂Informações/Logs/Voip.log.txt" ]; then
                  	echo " " > "./📂Informações/Logs/Voip.log.txt"
                fi
                cat server_log.txt >> ./📂Informações/Logs/Server.log.txt
                cat samp.log.txt >> ./📂Informações/Logs/Samp.log.txt
                cat samp.erro.log.txt >> ./📂Informações/Logs/Samp.erro.log.txt
                if [ -f "./svlog.txt" ]; then
                  	cat svlog.txt >> ./📂Informações/Logs/Voip.log.txt
                fi
                # Encerra o loop e o script
                break
                echo " " > server_log.txt
                rm samp.log.txt
                rm samp.erro.log.txt
            fi
        done &
        tail_pid=$!
    else
        # Comando de Iniciação do Servidor-----------------------------------------------------------------------------
        echo " 🔵   Executando em modo ${C1}Direto(Script 1.0)${C0}..."
        echo " 🔵   Salvando antiga Log ${C1}Direto(Script 1.0)${C0}..."
        cat server_log.txt >> ./📂Informações/Logs/Server.log.txt
        tail -n 10 -F server_log.txt
        echo " " > server_log.txt
        echo " 🔵   Iniciando ${C1}Iniciador direto${C0}."
        $(if [ "${Arquitetura}" == "arm64" ]; then echo -n "box86 ./samp03svr"; else echo -n ./"samp03svr"; fi)          #-
        exit
        # Comando de Iniciação do Servidor-----------------------------------------------------------------------------
    fi

    # Aguarda input do usuário
        while read line; do
            if [ "$line" = "${Stop_CMD}" ]; then
                # Salva as logs na pasta "./${Pasta_Base}/Logs/"./Informacoes/Informacoes.txt
                if [ ! -f "./📂Informações/Logs/Server.log.txt" ]; then
  					echo " " > "./📂Informações/Logs/Server.log.txt"
                fi
                cat server_log.txt >> ./📂Informações/Logs/Server.log.txt

                if [ ! -f "./📂Informações/Logs/Samp.log.txt" ]; then
                    echo " " > "./📂Informações/Logs/Samp.log.txt"
                fi
                cat samp.log.txt >> ./📂Informações/Logs/Samp.log.txt

                if [ ! -f "./📂Informações/Logs/Samp.erro.log.txt" ]; then
                  	echo " " > "./📂Informações/Logs/Samp.erro.log.txt"
                fi
                if [ ! -f "./📂Informações/Logs/Voip.log.txt" ]; then
                  	echo " " > "./📂Informações/Logs/Voip.log.txt"
                fi
                cat server_log.txt >> ./📂Informações/Logs/Server.log.txt
                cat samp.log.txt >> ./📂Informações/Logs/Samp.log.txt
                cat samp.erro.log.txt >> ./📂Informações/Logs/Samp.erro.log.txt
                if [ -f "./svlog.txt" ]; then
                  	cat svlog.txt >> ./📂Informações/Logs/Voip.log.txt
                fi
                kill $pid
                sleep 2
                break
                echo " " > server_log.txt
                rm samp.log.txt
                rm samp.erro.log.txt
            elif [ "$line" != "${Stop_CMD}" ]; then
            echo "🔴   Este Script ${C3}não${C0} possue suporte a ${C3}Comandos${C0}."
            else
                echo "🔴   Script ${C3}Falhou${C0} ou Forçado pelo ${C3}Kill${C0}."
            fi
        done
    kill $tail_pid
else
echo " 🔴   ${C3}Modo No-Code Detectado Iniciando Samp diretamente(Não recomendado), Iniciando...${C0}"

eval ${StartUP_CMD}
fi # If final
