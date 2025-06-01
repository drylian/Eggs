#!/bin/bash

CONTAINER_DIR="/home/container"
SAMBA_DIR="${CONTAINER_DIR}/samba"
CONFIG_FILE="${CONTAINER_DIR}/smb.conf"
PID_FILE="/tmp/smbd.pid"
STARTED_FLAG="${SAMBA_DIR}/started"

# 👉 Provisiona o domínio se ainda não foi inicializado
if [ ! -f "$STARTED_FLAG" ]; then
  echo "🛠️  Provisionando domínio Samba..."
  samba-tool domain provision \
    --use-rfc2307 \
    --realm=SAMBA.LOCAL \
    --domain=SAMBA \
    --server-role=dc \
    --dns-backend=SAMBA_INTERNAL \
    --host-name=samba-container \
    --configfile="$CONFIG_FILE" \
    --targetdir="$SAMBA_DIR"

  echo "🔧 Aplicando configurações de senha simplificadas..."
  samba-tool domain passwordsettings set --complexity=off --configfile="$CONFIG_FILE"

  touch "$STARTED_FLAG"
fi

start_smbd() {
  echo "🔁 Iniciando smbd..."
  smbd --foreground --no-process-group --debug-stdout --configfile="$CONFIG_FILE" &
  SMB_PID=$!
  echo "$SMB_PID" > "$PID_FILE"
  sleep 1
}

stop_smbd() {
  if [ -f "$PID_FILE" ]; then
    SMB_PID=$(cat "$PID_FILE")
    if ps -p "$SMB_PID" > /dev/null 2>&1; then
      echo "⛔ Parando smbd (PID $SMB_PID)..."
      kill "$SMB_PID"
      wait "$SMB_PID" 2>/dev/null
    fi
    rm -f "$PID_FILE"
  fi
}

restart_smbd() {
  stop_smbd
  start_smbd
}

echo "🟢 Samba Container Manager iniciado."
start_smbd

echo "Comandos disponíveis: /list, /add <user> <pass> <dir>, /rem <user>, /folders/<dir>, /exit"

while true; do
  echo -n "> "
  read -r cmd arg1 arg2 arg3

  case "$cmd" in
    /list)
      echo "📋 Lista de usuários Samba (samba-tool):"
      samba-tool user list --configfile="$CONFIG_FILE"
      ;;

    /add)
      username="$arg1"
      password="$arg2"
      share_dir="$arg3"
      full_path="${CONTAINER_DIR}/${share_dir}"

      if [[ -z "$username" || -z "$password" || -z "$share_dir" ]]; then
        echo "❗ Uso: /add <username> <password> <directory>"
        continue
      fi

      mkdir -p "$full_path"

      echo "➕ Criando usuário '$username'..."
      samba-tool user create "$username" "$password" --configfile="$CONFIG_FILE" || {
        echo "❌ Erro ao criar usuário '$username'"
        continue
      }

      if ! grep -q "^\[$share_dir\]" "$CONFIG_FILE"; then
        cat <<EOF >> "$CONFIG_FILE"

[$share_dir]
   path = $full_path
   browsable = yes
   writable = yes
   guest ok = no
   read only = no
   valid users = $username
EOF
      fi

      echo "✅ Usuário '$username' com acesso à pasta '$share_dir' criado."
      restart_smbd
      ;;

    /rem)
      username="$arg1"
      if [[ -z "$username" ]]; then
        echo "❗ Uso: /rem <username>"
        continue
      fi

      echo "🗑️  Removendo usuário '$username'..."
      samba-tool user delete "$username" --configfile="$CONFIG_FILE" || {
        echo "❌ Erro ao remover usuário '$username'"
        continue
      }

      restart_smbd
      ;;

    /folders/*)
      folder="${cmd#/folders/}"
      full_path="${CONTAINER_DIR}/${folder}"

      if [[ -d "$full_path" ]]; then
        echo "📁 Conteúdo de '$folder':"
        ls -lah "$full_path"
      else
        echo "❌ Diretório '$folder' não encontrado."
      fi
      ;;

    /exit)
      echo "🛑 Encerrando..."
      stop_smbd
      break
      ;;

    *)
      echo "❓ Comando desconhecido. Use /list, /add, /rem, /folders/<dir>, /exit"
      ;;
  esac
done
