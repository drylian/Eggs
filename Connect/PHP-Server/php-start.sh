#!/bin/ash

# Cores do Terminal
C0=$(echo -en "\u001b[0m") # Padrão
C1=$(echo -en "\e[1m\u001b[36m") # Cor Ciano Com negrito.
C2=$(echo -en "\e[1m\u001b[32m") # Cor Verde Com Negrito.
C3=$(echo -en "\e[1m\u001b[31m") # Cor Vermelho Com Negrito.
C4=$(echo -en "\e[1m\u001b[34m") # Cor Azul Com Negrito.
C5=$(echo -en "\e[1m\u001b[35m") # Cor Margeta Com Negrito.
B0="\e[1m" # Negrito


 

    if [ -z "$AUTO_UPDATE" ] || [ -z "$SUPORTE_ATIVO" ] || [ -z "$INICIADOR" ]; then
    echo "
    ${C3}.-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+-.
    ${C3}|   UMA OU MAIS VARIANTES DO EGG ESTÃO EM FALTA, BAIXE A VERSÃO MAIS RECENTE DO EGG NO GITHUB.   |
    ${C3}|                                 https://github.com/drylian/Eggs                                |
    ${C3}*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*+-+*-+*-+*+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+*-+.* 
    ${C0}"






















# Verifica se o arquivo php.php já foi editado
if grep -q 'root_path = "/home/container/Arquivos";' /home/container/Sistema/php.php; then
echo "O arquivo php.php já foi editado"
else
# Faz a substituição de texto no arquivo php.php
sed -i "s|\$root_path = \$_SERVER\['DOCUMENT_ROOT'\];|\$root_path = \"/home/container/Arquivos\";|g" /home/container/Sistema/php.php
echo "O arquivo php.php foi editado com sucesso"
fi
