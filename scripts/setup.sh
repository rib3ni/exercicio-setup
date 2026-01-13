#!/usr/bin/env bash
set -e

# Verificar se foi passado argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <comando>"
  echo "Exemplo: $0 curl"
  exit 1
fi

CMD="$1"

echo "A verificar se o comando '$CMD' está instalado..."

# Idempotência: só instala se não existir
if command -v "$CMD" >/dev/null 2>&1; then
  echo "✔ $CMD já está instalado."
else
  echo "➜ A instalar $CMD..."
  sudo apt update
  sudo apt install -y "$CMD"
fi

# Validação
echo "A validar funcionamento de $CMD..."
"$CMD" -I http://example.com | head -n 1

echo "Procedimento concluído com sucesso."
#!/bin/bash

echo "A atualizar índice de pacotes..."
sudo apt update

echo "A instalar curl..."
sudo apt install -y curl

echo "Instalação concluída com sucesso!"
