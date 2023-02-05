#!/bin/bash
#        ====================================================
#                 Base Script Egg Criado por Drylian
#        ====================================================
# Icones 🔴 🟠 🟡 🟢 🔵 🟣 🟤 ⚫ ⚪ ✅ ❌ 📍 ✂️ 🗑️ 🟧 🟨 ⬜ 
# Icones ☑️ ✖️ ❎ 💾 📓 📗 📘 📙 📝 📖 📚 📰 🗞️ 🏷️ 🟥 🟩 🟦 ⚙️ 
# Icones 📒 📔 📕 📑 📂 📁 🗂️ 🗃️ 🗄️ 📊 📈 📉 📇 📌 🟪 🟫 ⬛    
#

# Comandos Do painel Múdaveis
StartType="2" # Define que tipo de comando vai ser executado 1=Direto 2=Nohub.
Script_Type="2" # Define se este Script é Beta ou Alpha. 1=Alpha 2=Beta.
StartAMD="./base" # Comando Start para amd.
StartARM="./base" # Comando Start para arm.
Stop_CMD="Parar Servidor" # Comando para parar o Servidor.
Egg="Base" # Nome do egg que será executado.
Pasta_Base="📂Informações" # O Nome da pasta onde vai ser armazenada todas as informações do Script.
Base_txt="🟢Informações.txt" # Nome do Arquivo Onde vai Ficar os Verificadores do egg.
script_log="📔Script.log.txt" # Nome da Log que o Script vai Rodar.
debug_log="📔Debug.log.txt" # Nome da Log que vai rodar o Debug.
Base_Url="https://github.com/drylian/Eggs" #Link do github onde pode achar o egg.
version_file="./${Pasta_Base}/${Base_txt}" # Local onde a versão vai ser Armazenada.
version_remote="https://raw.githubusercontent.com/drylian/Eggs/main/Connect/SA-MP/Vers%C3%A3o.txt" #Local onde a Versão Latest vai ser vista
# Cores do Terminal
C0=$(echo -en "\u001b[0m") # Padrão
C1=$(echo -en "\e[1m\u001b[36m") # Cor Ciano Com negrito.
C2=$(echo -en "\e[1m\u001b[32m") # Cor Verde Com Negrito.
C3=$(echo -en "\e[1m\u001b[31m") # Cor Vermelho Com Negrito.
C4=$(echo -en "\e[1m\u001b[34m") # Cor Azul Com Negrito.
C5=$(echo -en "\e[1m\u001b[35m") # Cor Margeta Com Negrito.
B0=""
# Dependencias do Script
Arquitetura=$([ "$(uname -m)" == "x86_64" ] && echo "AMD64" || echo "ARM64") # Pega a Arquitetura da maquina
StartUP_CMD=${StartARM} [ "${Arquitetura}" == "ARM64" ] || StartUP_CMD=${StartAMD} # isto é o que de fato vai executar como StartUP_CMD
version=$(grep "🟢Versão Atual: " "$version_file" | cut -d' ' -f3) # Lendo a versão local
version2="${version} "
if [ "${SUPORTE_ATIVO}" == "1" ]; then Suporte_egg="✅ ${C1}Definido  ${C0}"; else Suporte_egg="❌ ${C3}Indefinido${C0}"; fi # Verificação do Suporte
if [ "${AUTO_UPDATE}" == "1" ]; then Updater_egg="✅ ${C1}Definido  ${C0}"; else Updater_egg="❌ ${C3}Indefinido${C0}"; fi # Verificação do Atualização.
if [ "${StartType}" == "1" ]; then Type_egg="✅ ${C1}Direto    ${C0}"; else Type_egg="✅ ${C1}NoHub     ${C0}"; fi # Verificação do TypeStart
if [ "${Script_Type}" == "1" ]; then Scriptstat="${C1}Alpha${C0}"; else Scriptstat="${C1}Beta ${C0}"; fi # Beta sim e não
if [ -z "${SUPORTE_ATIVO}" ]; then Suporte="❌ ${C3}Desativado${C0}"; else Suporte="✅ ${C1}Ativado   ${C0}"; fi # Verificação do Suporte egg
if [ -z "${AUTO_UPDATE}" ]; then Updater="❌ ${C3}Desativado${C0}"; else  Updater="✅ ${C1}Ativado   ${C0}"; fi # Verificação do Atualização egg
# Criação da Pasta de Vefiricação
if [[ ! -f "./${Pasta_Base}/${Base_txt}" ]]; then mkdir -p ./${Pasta_Base}; echo -e "🟢Informações Do Script\n#\n🟢Criado por Drylian\n🟢Github: https://github.com/drylian/Eggs\n🟢Versão Atual: PRÉ" > ./${Pasta_Base}/${Base_txt}; fi # Cria a pasta e o primeiro arquivo de versão.
# Carregar Versões
version_latest=$(curl -s "$version_remote" | grep "🟢Versão Latest: " | cut -d' ' -f3) # Lendo a versão remota
if [ "$version" != "$version_latest" ]; then version_update="> ${C2}${version_latest}${C0}"; else version_update="    "; fi # Verificando se há uma nova versão disponível.
# Inicio Do Script
if [ -z ${SUPORTE_ATIVO} ] || [ "${SUPORTE_ATIVO}" == "1" ]; then
    text="
    .+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-*.
    |                                          |                  ${C5}INICIANDO SCRIPT${C0}                   |
    |                   ${C5}:%*${C0}                    |+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-|
    |                  ${C4}:%@@*${C0}                   |                          |                          |
    |                 ${C5}-@@@@@#${C0}                  | Egg:${C1} ${Egg} ${C0}               | Arquitetura:${C1} ${Arquitetura} ${C0}      |
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
    for ((i=0; i<${#text}; i++)); do
      char="${text:$i:1}"
    if [[ $char != " " ]]; then
      echo -n "$char"
      sleep 0.0001
    else
      echo -n "$char"
    fi
  done
  if [ -z "$AUTO_UPDATE" ] || [ -z "$SUPORTE_ATIVO" ] || [ -z "${BETA_UPDATE}" ]; then
  echo "${C3}.-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-.
    ${C3}|   UMA OU MAIS VARIANTES DO EGG ESTÃO EM FALTA, BAIXE A VERSÃO MAIS RECENTE DO EGG NO GITHUB.   |
    ${C3}|                                 https://github.com/drylian/Eggs                                |
    ${C3}*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.* 
  ${C0}"
  fi
  passos=("Buscando atualizações" "Atualização Encontrada" "Baixando Atualização" "Verificando Configurações" "Baixando Configurações" "Executando o script de Iniciador")
  total_steps=77
  for i in $(seq 1 $total_steps); do
        bar=$(printf "%-${i}s" "=")
        percent=$(printf "%3d" $((i * 100 / total_steps)))
        step=""
  if [ "$percent" -ge 0 ] && [ "$percent" -le 30 ]; then
      step=${passos[0]}
        if [ "$version" == "PRÉ" ]; then
        sed -i '/🟢Versão Atual:*/d' ./${Pasta_Base}/${Base_txt}
        echo "🟢Versão Atual: ${version_latest}" >> "./${Pasta_Base}/${Base_txt}"
        elif [ "$version" != "$version_latest" ]; then
        step=${passos[1]}
        # Coloque Aqui oque vai ser removido para Atualizar
        fi
  elif [ "$percent" -ge 30 ] && [ "$percent" -le 60 ]; then
      step=${passos[1]}
  elif [ "$percent" -ge 60 ] && [ "$percent" -le 80 ]; then
      step=${passos[2]}
  elif [ "$percent" -ge 80 ] && [ "$percent" -le 100 ]; then
      step=${passos[3]}
  fi  
    echo -ne "$step [${bar// /=}] $percent%\r"
    sleep 0.1
  done
    echo ""
fi
