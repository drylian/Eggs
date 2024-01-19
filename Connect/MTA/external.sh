# Sistema do Nginx-----------------------------------------------
if [[ -f "./Status/Nginx_instalador" ]]; then
    echo "🟢 Nginx foi detectado, pulando Download."
else
    echo "🔴 Verificador do Nginx não foi detectado, Iniciando download."
    mkdir ./Cache
    git clone -q https://github.com/finnie2006/ptero-nginx ./Cache
    mkdir ./nginx
    cp -r ./Cache/nginx/* ./nginx
    rm -rf ./Cache
    mkdir ./Status
    curl -s https://raw.githubusercontent.com/drylian/Eggs/main/Connect/Nginx/Leiame.txt -o ./Status/Leia-me.txt
    touch ./Status/Nginx_instalador
fi
# Fim do Nginx---------------------------------------------------
# Script do default.conf
if [[ -f "./nginx/conf.d/default.conf" ]]; then
    echo "🟢 Default.conf ja criado, pulando."
else
    cat >./nginx/conf.d/default.conf <<EOL
server {
    listen ${SERVER_PORT};
    root /home/container/Resources;
    server_name "";
    autoindex off;
}
EOL
fi
# Fim

# Permissões-----------------------------------------------------
echo "🟢 Setando permissões padrões."
chmod 777 ./*
# Fim Permissões-------------------------------------------------

# Limpar Tmp-----------------------------------------------------
echo "🟢 Removendo Arquivos Temporarios "
rm -rf /home/container/tmp/*
# Fim Limpar Tmp-------------------------------------------------
echo "🟢 Starting Nginx..."
nohup /usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/ >/dev/null 2>&1 &
host_ip=$(ip route | awk 'NR==1 {print $3}')
echo "Nginx iniciado em : ${host_ip}:${SERVER_PORT}"
