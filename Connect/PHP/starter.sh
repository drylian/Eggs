#!/bin/bash
echo "✨  Verificando nginx e php-fpm..."

# Verifica se os diretórios nginx e php-fpm não existem
if [[ ! -d "./nginx" || ! -d "./php-fpm" ]]; then
    echo "❌  nginx ou php-fpm não encontrados, baixando..."
    git clone https://github.com/Sigma-Production/ptero-eggs ./temp
else
    echo "✅  nginx e php-fpm já existem, continuando..."
fi

# Verifica se o diretório nginx existe
if [[ -d "./nginx" ]]; then
    echo "✅  O diretório nginx existe continuando..."
else
    echo "❌  O diretório nginx não existe, copiando..."
    cp -r ./temp/nginx ./
fi

# Verifica se o diretório php-fpm existe
if [[ -d "./php-fpm" ]]; then
    echo "✅  O diretório php-fpm existe continuando..."
else
    echo "❌  O diretório php-fpm não existe, copiando..."
    cp -r ./temp/php-fpm ./
fi
ls /usr/sbin 

# Limpa arquivos temporários
echo "✅  Limpando arquivos temporários..."
if [[ -d "./temp" ]]; then rm -rf ./temp; fi
if [[ -d "./tmp" ]]; then rm -rf ./tmp; fi
mkdir ./tmp

# Inicia o PHP-FPM
echo "✅  Iniciando PHP-FPM no php ${__PHP_VERSION}..."
/usr/sbin/php-fpm${__PHP_VERSION} --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

# Inicia o Nginx
echo "✅  Iniciando Nginx..."
echo "✅  Iniciado com sucesso"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/