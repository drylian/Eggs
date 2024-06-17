#!/bin/bash
echo "✨  Verificando nginx..."

if [[ -d "./nginx" || -d "./php-fpm" ]]; then
    git clone https://github.com/Sigma-Production/ptero-eggs ./temp
fi

if [[ -d "./nginx" ]]; then
    echo "✅  O diretório nginx existe continuando..."
else
    echo "❌  O diretório nginx não existe, baixando..."
    cp -r ./temp/nginx ./
fi

if [[ -d "./php-fpm" ]]; then
    echo "✅  O diretório php-fpm existe continuando..."
else
    echo "❌  O diretório php-fpm não existe, baixando..."
    cp -r ./temp/php-fpm ./
fi

echo "✅  limpando arquivos temporarios..."
if [[ -d "./temp" ]]; then rm -rf ./temp; fi;
if [[ -d "./tmp" ]]; then rm -rf ./tmp; fi;

echo "✅  Iniciando PHP-FPM no php ${__PHP_VERSION}..."
/usr/sbin/php-fpm${__PHP_VERSION} --fpm-config /home/container/php-fpm/php-fpm.conf --daemonize

echo "✅  Iniciando Nginx..."
echo "✅  Iniciado com sucesso"
/usr/sbin/nginx -c /home/container/nginx/nginx.conf -p /home/container/