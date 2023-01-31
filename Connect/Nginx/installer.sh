mkdir -p /mnt/server
cd /mnt/server
apk --update add git curl file unzip tar autoconf automake git wget

# Baixando o Sistema
git clone https://github.com/finnie2006/ptero-nginx ./temp

cp -r ./temp/nginx /mnt/server/
cp -r ./temp/php-fpm /mnt/server/

# Limpando Tralhas
rm -rf ./temp
