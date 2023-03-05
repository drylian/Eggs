#!/bin/bash
#        ====================================================
#                Open-MP Script Egg Criado por Drylian
#        ====================================================
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌ 📍 ✂️ 🗑️ 🟧 🟨 ⬜ 
# Icones ☑️ ✖️ ❎ 💾 📓 📗 📘 📙 📝 📖 📚 📰 🗞️ 🏷️ 🟥 🟩 🟦 ⚙️ 
# Icones 📒 📔 📕 📑 📂 📁 🗂️ 🗃️ 🗄️ 📊 📈 📉 📇 📌 🟪 🟫 ⬛    
#

# Comandos Do painel Múdaveis
if [ -z "$INICIADOR" ]; then StartType="1"; else StartType="${INICIADOR}"; fi # Define que tipo de comando vai ser executado 0=Direto 1=Nohub.
Script_Type="2" # Define se este Script é Beta ou Alpha. 1=Alpha 2=Beta.
StartAMD="./omp-server" # Comando Start para amd.
StartARM="sh -c box86 ./omp-server" # Comando Start para arm.
Stop_CMD="Parar Servidor" # Comando para parar o Servidor.
Permissoes_padroes="chmod 777 ./*" # Define as permissões do arquivos, por padrão recomendo chmod 777 ./*.
Egg="Open-MP             " # O Nome do egg que será executado, lembrando que o numero de caracteres maximos dentro "" é 20 oque não tiver de nome, use em espaços.
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
            sed -i '/🟢SAMP Instalado/d' ./📂Informações/🟢Informações.txt
            sed -i '/🟢SAMP Npc Instalado/d' ./📂Informações/🟢Informações.txt
            sed -i '/🟢SAMP Announce Instalado/d' ./📂Informações/🟢Informações.txt
            if [ "${SAMP_VOIP}" == "1" ]; then -i '/SAMP Voip Instalado/d' ./📂Informações/🟢Informações.txt; fi
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
    echo " 🔵   Iniciando Script de ${C1}Verificação e Instalação${C0} das dependecias..."
    # Dependencias do Samp
    echo " 🔵   Validando se Existem as ${C1}Dependencias necessarias${C0} para a execução deste Script..."
    sleep 0.5

    echo " "
    
    if [ -d "./gamemodes" ]; then
        echo " 🔵   Pasta ${C1}/gamemodes${C0} foi detectada, Continuando Validação..."
        if [ ! "$(ls ./gamemodes/ | grep '.amx')" ]; then
            echo " 🔴   ${C3}Não existe nem um .amx na pasta /gamemodes, oque torna impossivel o Samp funcionar...${C0}"
            if [ ! "$(ls ./gamemodes/ | grep '.pwn')" ]; then
                echo " 🔴   ${C3}Não existe um .pwn na pasta /gamemodes, builde e instale pelo menos um AMX na pasta /gamemodes e inicie novamente.${C0}"
                exit
            else
                echo " 🟡   Um PWN foi detectado, builde ele e inicie o script novamente."
                exit
            fi
        else
            echo " 🔵   ${C1}Gamemode${C0} foi detectada, Continuando Validação..."
            if [[ -f "./server.cfg" ]]; then
                echo " 🔵   ${C1}Server.cfg${C0} foi detectada, Verificando Gamemode..."
                # Extrai o valor da configuração "gamemode0" do arquivo server.cfg
                Gm_namemode="$(awk -F ' ' '/^gamemode0/{print $2}' server.cfg)"

                # Remove qualquer espaço em branco no início ou no final da string
                Gm_namemode=$(echo "${Gm_namemode}" | awk '{$1=$1;print}')

                if [[ -f "./gamemodes/${Gm_namemode}.amx" ]]; then 
                    echo " 🔵   ${C1}${Gm_namemode}.amx${C0} foi detectada, Iniciando Script..."
                else
                    echo " 🔴   ${C3}Não existe a --> ${Gm_namemode}.amx <-- na pasta /gamemodes como especificado na server.cfg, verificando a existencias de PWM${C0}"
                    if [[ -f "./gamemodes/${Gm_namemode}.pwn" ]]; then
                        echo " 🔴   ${C3}Não existe um --> ${Gm_namemode}.pwn <-- na pasta /gamemodes, verificando outros pwns...${C0}"
                        if [ ! "$(ls ./gamemodes/ | grep '.pwn')" ]; then
                            echo " 🔴   ${C3}Não existe um .pwn na pasta /gamemodes, builde e instale pelo menos um AMX na pasta /gamemodes e inicie novamente.${C0}"
                            exit
                        else
                            echo " 🟡   PWN foi detectado, builde ele,e escreva o nome dele na Server.cfg e depois inicie o script novamente."
                            exit
                        fi
                    else
                        echo " 🟡   Um ${Gm_namemode}.pwn foi detectado, builde ele e inicie o script novamente."
                        exit
                    fi
                fi
            fi
            if [[ -f "./server.cfg" ]]; then
                echo " 🔵   ${C1}Server.cfg${C0} foi detectada, iniciando script..."
            else
                echo "${C3} 🔴   Server.cfg não foi detectada, configure a server.cfg e inicie o script novamente.${C0}"
                exit
            fi
        fi
    else
        echo " ${C3} 🔴   Pasta /gamemodes não foi detectada${C0}, Verifique a Pasta gamemodes e inicie o script novamente."
        exit
    fi
	
    # Adicionando Debug no Script
	if grep -q "crash-detect.so" server.cfg; then
        echo "crash-detect.so already present in plugins"
    else
        sed -i '/plugins/ s/$/ crash-detect.so/' server.cfg
        echo "crash-detect.so added to plugins"
    fi
		
    echo " "
    if grep -q "sv_port ${VOIP_PORT}" "./server.cfg"; then
        echo ""
    else
        if grep -q "sv_port" "./server.cfg"; then
            sed -i "/sv_port/c\sv_port ${VOIP_PORT}" "./server.cfg"
        else
            echo "" >> "./server.cfg"
            echo "sv_port ${VOIP_PORT}" >> "./server.cfg"
        fi
    fi
    
    # Samp Verificador
    if grep -q "🟢SAMP Instalado" "./📂Informações/🟢Informações.txt"; then
        echo " 🔵   O ${C1}SA-MP${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./samp03svr" ]]; then
            echo " 🔵   O Arquivo ${C1}SA-MP${C0} foi verificado, Continuando iniciação..."
        else
            echo " 🟡   O Arquivo ${C1}SA-MP${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/samp03svr "https://github.com/drylian/Eggs/releases/latest/download/samp03svr"
            echo " 🔵   O Arquivo ${C1}SA-MP${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
        fi
    else
        echo " 🔵   O ${C1}SA-MP${C0} ${C3}não${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./samp03svr" ]]; then
            echo " 🟡   O Arquivo ${C1}SA-MP${C0} foi encontrado, porém não está nas normas do script, Deletando..."
            rm -f ./samp03svr
            echo " 🟢   O Baixando Arquivo ${C1}SA-MP${C0} verificado..."
            curl -s -L -o /home/container/samp03svr "https://github.com/drylian/Eggs/releases/latest/download/samp03svr"
            echo " 🔵   O Arquivo ${C1}SA-MP${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Instalado" >> "./📂Informações/🟢Informações.txt"
        else
            echo " 🔵   O Arquivo ${C1}SA-MP${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/samp03svr "https://github.com/drylian/Eggs/releases/latest/download/samp03svr"
            echo " 🔵   O Arquivo ${C1}SA-MP${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Instalado" >> "./📂Informações/🟢Informações.txt"
        fi
    fi

    echo " "
    # Samp-npc Verificador
    if grep -q "🟢SAMP Npc Instalado" "./📂Informações/🟢Informações.txt"; then
        echo " 🔵   O ${C1}SA-MP Npc${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./samp-npc" ]]; then
            echo " 🔵   O Arquivo ${C1}SA-MP Npc${C0} foi verificado, Continuando iniciação..."
        else
            echo " 🟡   O Arquivo ${C1}SA-MP Npc${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
            echo " 🔵   O Arquivo ${C1}SA-MP Npc${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
        fi
    else
        echo " 🔵   O ${C1}SA-MP Npc${C0} ${C3}não${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./samp-npc" ]]; then
            echo " 🟡 O Arquivo ${C1}SA-MP Npc${C0} foi encontrado, porém não está nas normas do script, Deletando..."
            rm -f ./samp-npc
            echo " 🟢   O Baixando Arquivo ${C1}SA-MP Npc${C0} verificado..."
            curl -s -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
            echo " 🔵   O Arquivo ${C1}SA-MP Npc${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Npc Instalado" >> "./📂Informações/🟢Informações.txt"
        else
            echo " 🔵   O Arquivo ${C1}SA-MP Npc${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/samp-npc "https://github.com/drylian/Eggs/releases/latest/download/samp-npc"
            echo " 🔵   O Arquivo ${C1}SA-MP Npc${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Npc Instalado" >> "./📂Informações/🟢Informações.txt"
        fi
    fi

    echo " "

    # Samp Announce Verificador
    if grep -q "🟢SAMP Announce Instalado" "./📂Informações/🟢Informações.txt"; then
        echo " 🔵   O ${C1}SA-MP Announce${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./announce" ]]; then
            echo " 🔵   O Arquivo ${C1}SA-MP Announce${C0} foi verificado, Continuando iniciação..."
        else
            echo " 🟡   O Arquivo ${C1}SA-MP Announce${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
            echo " 🔵   O Arquivo ${C1}SA-MP Announce${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
        fi
    else
        echo " 🔵   O ${C1}SA-MP Announce${C0} ${C3}não${C0} foi detectado como Instalado, Verificando Arquivo..."
        if [[ -f "./announce" ]]; then
            echo " 🟡   O Arquivo ${C1}SA-MP Announce${C0} foi encontrado, porém não está nas normas do script, Deletando..."
            rm -f ./announce
            echo " 🟢   O Baixando Arquivo ${C1}SA-MP${C0} verificado..."
            curl -s -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
            echo " 🔵   O Arquivo ${C1}SA-MP Announce${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Announce Instalado" >> "./📂Informações/🟢Informações.txt"
        else
            echo " 🟡   O Arquivo ${C1}SA-MP Announce${C0} ${C3}não${C0} foi encontrado, Baixando..."
            curl -s -L -o /home/container/announce "https://github.com/drylian/Eggs/releases/latest/download/announce"
            echo " 🔵   O Arquivo ${C1}SA-MP Announce${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
            echo "🟢SAMP Announce Instalado" >> "./📂Informações/🟢Informações.txt"
        fi
    fi

    # Samp Voice Verificador
    if [ "${SAMP_VOIP}" == "1" ]; then
        echo " "
        echo " 🔵   O ${C1}SA-MP Voip${C0} Beta está ativado, Verificando pasta..."
        if [[ -d "plugins" ]]; then
        echo " 🔵   A pasta ${C1}Plugins${C0} foi detectada, Configurando..."
            if grep -q "🟢SAMP Voip Instalado" "./📂Informações/🟢Informações.txt"; then
                echo " 🔵   O ${C1}SA-MP Voip${C0} foi detectado como Instalado, Verificando Arquivo..."
                if [[ -f "./plugins/sampvoice.so" ]]; then
                    echo " 🔵   O Arquivo ${C1}SA-MP Voip${C0} foi verificado, Continuando iniciação..."
                else
                    echo " 🟡   O Arquivo ${C1}SA-MP Voip${C0} ${C3}não${C0} foi encontrado, Baixando..."
                    curl -s -L -o /home/container/plugins/sampvoice.so "https://github.com/drylian/Eggs/releases/latest/download/sampvoice.so"
                    echo " 🔵   O Arquivo ${C1}SA-MP Voip${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
                fi
            else
                echo " 🔵   O ${C1}SA-MP Voip${C0} ${C3}não${C0} foi detectado como Instalado, Verificando Arquivo..."
                if [[ -f "./plugins/sampvoice.so" ]]; then
                    echo " 🟡   O Arquivo ${C1}SA-MP Voip${C0} foi encontrado, porém não está nas normas do script, Deletando..."
                    rm -f ./plugins/sampvoice.so
                    echo " 🟢   O Baixando Arquivo ${C1}SA-MP Voip${C0} verificado..."
                    curl -s -L -o /home/container/plugins/sampvoice.so "https://github.com/drylian/Eggs/releases/latest/download/sampvoice.so"
                    echo " 🔵   O Arquivo ${C1}SA-MP Voip${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
                    echo "🟢SAMP Voip Instalado" >> "./📂Informações/🟢Informações.txt"
                else
                    echo " 🟡   O Arquivo ${C1}SA-MP Voip${C0} ${C3}não${C0} foi encontrado, Baixando..."
                    curl -s -L -o /home/container/plugins/sampvoice.so "https://github.com/drylian/Eggs/releases/latest/download/sampvoice.so"
                    echo " 🔵   O Arquivo ${C1}SA-MP Voip${C0} foi ${C2}baixado${C0}, Continuando iniciação..."
                    echo "🟢SAMP Voip Instalado" >> "./📂Informações/🟢Informações.txt"
                fi
            fi
        else
            echo " 🟡   A Pasta ${C3}Plugins${C0} não foi encontrada, pulando etapa."
        fi
    fi

    echo " "

    # Server.cfg Editor
    if [[ -f "./server.cfg" ]]; then
        echo " 🔵   Editando ${C1}Server.cfg${C0}. Procedimento padrão..."
        echo " 🔵   Configurando ${C1}Linha Plugins${C0} da ${C1}Server.cfg${C0}, removendo ${C3}.ddl(Se tiver)${C0}..."
        awk '/plugins/{gsub(/.dll/,"",$0);print} !/plugins/' server.cfg > server.cfg.etp.1.txt
        echo " 🔵   Configurando ${C1}Linha Plugins${C0} da ${C1}Server.cfg${C0}, removendo ${C3}.so(Se tiver)${C0}..."
        awk '/plugins/{gsub(/.so/,"",$0);print} !/plugins/' server.cfg.etp.1.txt > server.cfg.etp.2.txt
        echo " 🔵   Configurando ${C1}Linha Plugins${C0} da ${C1}Server.cfg${C0}, Adicionando ${C2}.so${C0} na linha plugins..."
        awk '/plugins/{for(i=2;i<=NF;i++) $i=$i".so"; print} !/plugins/' server.cfg.etp.2.txt > server.cfg.etp.3.txt
        echo " 🔵   Configurando ${C1}Linha Plugins${C0} da ${C1}Server.cfg${C0}, Sobrescrevendo ${C1}Server.cfg${C0}..."
        mv ./server.cfg ./${Pasta_Base}/Antiga-Server.Cfg
        rm ./server.cfg.etp.1.txt
        rm ./server.cfg.etp.2.txt
        mv ./server.cfg.etp.3.txt ./server.cfg
        echo " 🔵   ${C1}Server.cfg${C0} foi editada com ${C2}Sucesso${C0}, Carregando informações do Servidor..."
        echo " 🔵   Uma Copia da Antiga ${C1}Server.cfg${C0} foi enviada para ${C2}/${Pasta_Base}/Logs${C0} para caso precise dela."
    else
        echo " 🔴   ${C3}Server.cfg não encontrada, Arrume Isto para Continuar o script...${C0}"
        exit
    fi

    echo " "
                                
    echo -e ".*******************************************************************.
|                      ${C5}INFORMAÇÕES DO SERVIDOR${C0}                      |"
    # Define as variáveis e da Server.cfg
    Nome_Servidor="$(awk '/^hostname/{$1=""; print $0}' server.cfg)"
    Nome_gamemode="$(awk '/^gamemode0/{$1=""; print $0}' server.cfg)"
    SAMP_Porta="$(awk '/^port/{print $2}' server.cfg)"
    Voip_Porta="$(awk '/^sv_port/{print $2}' server.cfg)"
    Max_Jogadores="$(awk '/^maxplayers/{print $2}' server.cfg)"
    Max_Npc="$(awk '/^maxnpc/{print $2}' server.cfg)"

    # Define primeira coluna
    nome_1="Nome do Servidor"
    nome_2="Nome da Gamemode"
    nome_3="Porta do Samp"
    nome_4="Porta do Voip"
    nome_5="Maximo de Jogadores"
    nome_6="Maximo de Npcs"

    # Armazena as variáveis em um array
    nomes=(nome_1 nome_2 nome_3 nome_4 nome_5 nome_6)
    variantes=(Nome_Servidor Nome_gamemode SAMP_Porta Voip_Porta Max_Jogadores Max_Npc)

    # Define o tamanho máximo de caracteres para cada coluna
    coluna1=20
    coluna2=42

    # Imprime o cabeçalho da tabela
    printf "."
    for i in $(seq 1 $coluna1); do
        printf "*"
    done
        printf "*****"
    for i in $(seq 1 $coluna2); do
        printf "*"
    done
    printf ".\n"

    # Loop sobre as variáveis
    for i in "${!nomes[@]}"; do
        # Obtém o nome do alias
        nome=$(eval echo "\${${nomes[i]}}")
        # Obtém o valor da variável usando o alias
        valor=$(eval echo "\${${variantes[i]}}")
        # Imprime a linha da tabela com o valor da variável formatado
        printf "|${B0} %-*s ${C0}|${C1} %-*s ${C0}|\n" $coluna1 "$nome" $coluna2 "$valor"
    done

    printf "*"
        for i in $(seq 1 $coluna1); do
        printf "*"
    done
    printf "*****"
    for i in $(seq 1 $coluna2); do
        printf "*"
    done
    printf "*\n"

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
        chmod +w samp.log.txt samp.erro.log.txt
        # Continua a exibir as últimas linhas do arquivo de log a cada segundo
        while true; do
            tail -n 10 -F server_log.txt
            tail -n 10 -F samp.erro.log.txt
            tail -n 10 -F samp.log.txt
            sleep 1
            # Verifica se o processo do aplicativo ainda está ativo
            if [ -z "$pid" ] || ! kill -0 $pid 2>/dev/null; then
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
        $(if [ "${Arquitetura}" == "arm64" ]; then echo -n "box86 ./omp-server"; else echo -n ./omp-server; fi)          #-
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
