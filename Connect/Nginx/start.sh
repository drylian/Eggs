echo "iniciando Nginx"
rm -f Nginx.sh
echo "Baixando iniciador"
wget https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/Nginx.sh
echo "Iniciando Iniciador"
chmod 777 Nginx.sh
sh ./Nginx.sh
