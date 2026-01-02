#!/bin/bash
#        ====================================================
#                 Base Script Egg Criado por drysius
#        ====================================================
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌ 📍 ✂️ 🗑️ 🟧 🟨 ⬜ 
# Icones ☑️ ✖️ ❎ 💾 📓 📗 📘 📙 📝 📖 📚 📰 🗞️ 🏷️ 🟥 🟩 🟦 ⚙️ 
# Icones 📒 📔 📕 📑 📂 📁 🗂️ 🗃️ 🗄️ 📊 📈 📉 📇 📌 🟪 🟫 ⬛    
#

# Comandos Do painel Múdaveis
StartType="0" # Define que tipo de comando vai ser executado 0=Direto 1=Nohub.
Script_Type="2" # Define se este Script é Beta ou Alpha. 1=Alpha 2=Beta.
StartAMD="./base" # Comando Start para amd.
StartARM="./base" # Comando Start para arm.
Stop_CMD="Parar Servidor" # Comando para parar o Servidor.
Permissoes_padroes="chmod 777 ./*" # Define as permissões do arquivos, por padrão recomendo chmod 777 ./*.
Egg="Base                " # O Nome do egg que será executado, lembrando que o numero de caracteres maximos dentro "" é 20 oque não tiver de nome, use em espaços.
Pasta_Base="📂Informações" # O Nome da pasta onde vai ser armazenada todas as informações do Script.
Base_txt="🟢Informações.txt" # Nome do Arquivo Onde vai Ficar os Verificadores do egg.
script_log="📔Script.log.txt" # Nome da Log que o Script vai Rodar.
debug_log="📔Debug.log.txt" # Nome da Log que vai rodar o Debug.
Base_Url="https://github.com/drysius/Eggs" #Link do github onde pode achar o egg.
version_file="./${Pasta_Base}/${Base_txt}" # Local onde a versão vai ser Armazenada.
version_remote="https://raw.githubusercontent.com/drysius/Eggs/main/Connect/SA-MP/Vers%C3%A3o.txt" #Local onde a Versão Latest vai ser vista
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
if [[ ! -f "./${Pasta_Base}/${Base_txt}" ]]; then mkdir -p ./${Pasta_Base}; echo -e "🟢Informações Do Script\n#\n🟢Criado por drysius\n🟢Github: https://github.com/drysius/Eggs\n🟢Versão Atual: PRÉ" > ./${Pasta_Base}/${Base_txt}; fi # Cria a pasta e o primeiro arquivo de versão.
if [[ ! -d "${Pasta_Base}/Logs" ]]; then mkdir -p ./${Pasta_Base}/Logs; fi
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "AMD64" || echo "ARM64") # Pega a Arquitetura da maquina
StartUP_CMD=${StartARM} [ "${Arquitetura}" == "ARM64" ] || StartUP_CMD=${StartAMD} # isto é o que de fato vai executar como StartUP_CMD
version=$(grep "🟢Versão Atual: " "$version_file" | cut -d' ' -f3) # Lendo a versão local
if [ "${version}" == "PRÉ" ]; then version2="${version}"; else version2="${version} "; fi #organiza o tamanho da versão
if [ "${SUPORTE_ATIVO}" == "1" ]; then Suporte_egg="✅ ${C1}Definido  ${C0}"; else Suporte_egg="❌ ${C3}Indefinido${C0}"; fi # Verificação do Suporte
if [ "${AUTO_UPDATE}" == "1" ]; then Updater_egg="✅ ${C1}Definido  ${C0}"; else Updater_egg="❌ ${C3}Indefinido${C0}"; fi # Verificação do Atualização.
if [ "${StartType}" == "0" ]; then Type_egg="✅ ${C1}Direto    ${C0}"; else Type_egg="✅ ${C1}NoHub     ${C0}"; fi # Verificação do TypeStart
if [ "${Script_Type}" == "1" ]; then Scriptstat="${C1}Alpha${C0}"; else Scriptstat="${C1}Beta ${C0}"; fi # Beta sim e não
if [ -z "${SUPORTE_ATIVO}" ]; then Suporte="❌ ${C3}Desativado${C0}"; else Suporte="✅ ${C1}Ativado   ${C0}"; fi # Verificação do Suporte egg
if [ -z "${AUTO_UPDATE}" ]; then Updater="❌ ${C3}Desativado${C0}"; else  Updater="✅ ${C1}Ativado   ${C0}"; fi # Verificação do Atualização egg
# Carregar Versões
version_latest=$(curl -s "$version_remote" | grep "🟢Versão Latest: " | cut -d' ' -f3) # Lendo a versão remota
if [ "$version" != "$version_latest" ]; then version_update="> ${C2}${version_latest}${C0}"; else version_update="    "; fi # Verificando se há uma nova versão disponível.
# Inicio Do Script
if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then
    echo "
    .+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-*.
    |                                          |                  ${C5}INICIANDO SCRIPT${C0}                   |
    |                   ${C5}:%*${C0}                    |+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-|
    |                  ${C4}:%@@*${C0}                   |                          |                          |
    |                 ${C5}-@@@@@#${C0}                  | ${C0}Egg:${C1} ${Egg}${C0}| Arquitetura:${C1} ${Arquitetura} ${C0}      |
    |                ${C4}=@@@@@@@%.${C0}                | Versão: ${C1}${version2}${C0} ${version_update}        | Script: ${C1}${Scriptstat}${C0}            |
    |               ${C5}+@@@@#%@@@%:${C0}               | StartType: ${Type_egg} |                          |
    |              ${C4}+@@@@= .#@@@%:${C0}              |                          |                          |
    |             ${C5}*@@@@-    #@@@@-${C0}             |+*-+*-+*-+*-+*-+*-+*-+*-+*|+*-+*-+*-+*-+*-+*-+*-+*-+*|
    |            ${C4}#@@@@:      *@@@@=${C0}            |     ${C5}VARIANTES DO EGG${C0}     |   ${C5}ATIVADOS/DESATIVADOS${C0}   |
    |          ${C5}.%@@@%:        +@@@@+${C0}           |+*-+*-+*-+*-+*-+*-+*-+*-+*|+*-+*-+*-+*-+*-+*-+*-+*-+*|
    |         ${C4}:%@@@%.          =@@@@*${C0}          |                          |                          |
    |        ${C5}:%@@@#   ++++++++++@@@@@*${C0}         | Suporte: ${Suporte_egg}   | Suporte: ${Suporte}   |
    |       ${C4}=@@@@#  .%@@@@@@@@@@@@@@@@%.${C0}       |                          |                          |
    |      ${C5}-%%%%#. .+%##########%%%%%#%*.${C0}      | Update: ${Updater_egg}    | Update: ${Updater}    |
    |    ${C4} -------  ------------------------${C0}    |                          |                          |
    |                                          |                          |                          |
    *-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*°-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.*
    "  
    if [ -z "$AUTO_UPDATE" ] || [ -z "$SUPORTE_ATIVO" ]; then
    echo "
    ${C3}.-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-.
    ${C3}|   UMA OU MAIS VARIANTES DO EGG ESTÃO EM FALTA, BAIXE A VERSÃO MAIS RECENTE DO EGG NO GITHUB.   |
    ${C3}|                                 https://github.com/drysius/Eggs                                |
    ${C3}*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.* 
    ${C0}"
    fi
        # Atualizações
    if [ "${AUTO_UPDATE}" == "1" ]; then
        echo " 🔵 A ${C1}Atualizações Automatica${C0} está ${C2}Ativada${C0}, Buscando Atualizações..."
        if [ "$version" == "PRÉ" ]; then
            echo " 🔵   ${C1}Versão Inicial${C0} detectada, Iniciando Downloads"
            sed -i '/🟢Versão Atual:*/d' ./${Pasta_Base}/${Base_txt}
            echo  "🟢Versão Atual: ${version_latest}" >> "./${Pasta_Base}/${Base_txt}"
        elif [ "$version" != "$version_latest" ]; then
            echo " 🔵   Nova ${C1}Versão${C0} detectada, Iniciando Atualização."
            # Oque vai Fazer se tiver atualização
            
            # Seta a versão mais atual
            sed -i '/🟢Versão Atual:*/d' ./${Pasta_Base}/${Base_txt}
            echo  "🟢Versão Atual: ${version_latest}" >> "./${Pasta_Base}/${Base_txt}"
            echo ""
            echo " 🔵   Sistema foi ${C1}Atualizado${C0} versão atual ${version}..."
        elif [ "$version" == "$version_latest" ]; then
            echo " 🔵   Sistema está ${C1}Atualizado${C0} versão atual ${version}..."
        fi
    else
        echo " 🟡   A ${C1}Atualizações Automatica${C0} está ${C3}Desativada${C0}, Pulando etapa..."
    fi
    echo " 🔵   Iniciando Script de ${C1}Verificação e Instalação${C0} das dependecias..."
    # Aqui ficará o Script
    























    echo ""
    echo " 🔵   Setando ${C1}Permissões${C0} padrões."
    eval "$Permissoes_padroes"
    # Fim do Script
    echo " 🔵   ${C1}Verificação e Instalação${C0} dependecias foi terminado, Iniciando Inicializador..."
    # O StartType do comando não necessita mudar
    if [ "${StartType}" == "1" ]; then
        nohup ${StartUP_CMD} > ${Egg}.log.txt 2> ${Egg}.erro.log.txt &
        pid=$!
        # Continua a exibir as últimas linhas do arquivo de log a cada segundo
        while true; do
            tail -n 10 -F ${Egg}.log.txt
            tail -n 10 -F ${Egg}.erro.log.txt
            sleep 1
            # Verifica se o processo do aplicativo ainda está ativo
            if ! kill -0 $pid 2> /dev/null; then
                # Salva as logs na pasta "./${Pasta_Base}/Logs/"./Informacoes/Informacoes.txt
                echo "🔴   ${C3}O ${Egg} foi finalizado sem aviso, provavelmente erro interno, desligando script${C0}..."
                if [ ! -f "./${Pasta_Base}/Logs/${Egg}.log.txt" ]; then
                  	echo " " > "./${Pasta_Base}/Logs/${Egg}log.txt"
                fi
                
                if [ ! -f "./${Pasta_Base}/Logs/${Egg}.log.txt" ]; then
                  	echo " " > "./${Pasta_Base}/Logs/${Egg}.log.txt"
                fi

                cat ${Egg}.log.txt >> ./${Pasta_Base}/Logs/${Egg}.log.txt
                cat ${Egg}.erro.log.txt >> ./${Pasta_Base}/Logs/${Egg}.erro.log.txt

                rm ${Egg}.log.txt
                rm ${Egg}.erro.log.txt
                break
            fi
        done &
        tail_pid=$!
    else
        eval ${StartUP_CMD}
    fi
    # Aguarda input do usuário
        while read line; do
            if [ "$line" = "${Stop_CMD}" ]; then
                kill $pid
                echo "🟢   ${C1}Comando de Desligamento${C0} Executado, Salvando Arquivos..."
                if [ ! -f "./${Pasta_Base}/Logs/${Egg}.log.txt" ]; then
                  	echo " " > "./${Pasta_Base}/Logs/${Egg}log.txt"
                fi

                if [ ! -f "./${Pasta_Base}/Logs/${Egg}.log.txt" ]; then
                  	echo " " > "./${Pasta_Base}/Logs/${Egg}.log.txt"
                fi

                cat ${Egg}.log.txt >> ./${Pasta_Base}/Logs/${Egg}.log.txt
                cat ${Egg}.erro.log.txt >> ./${Pasta_Base}/Logs/${Egg}.erro.log.txt

                rm ${Egg}.log.txt
                rm ${Egg}.erro.log.txt
                sleep 5
                break
            elif [ "$line" != "${Stop_CMD}" ]; then
                echo "🔴   Este Script ${C3}não${C0} possue suporte a ${C3}Comandos${C0}."
            else
                echo "🔴   Script ${C3}Falhou${C0} ou Forçado pelo ${C3}Kill${C0}."
            fi
        done
    kill $tail_pid
fi # If final