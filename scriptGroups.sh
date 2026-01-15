#!/bin/bash

# Define o usuário correto (com ou sem sudo)
if [ -n "$SUDO_USER" ]; then
    CURRENT_USER="$SUDO_USER"
else
    CURRENT_USER="$(whoami)"
fi

if [ $# -lt 1 ]; then
    echo "Uso: ./scriptGroups.sh {list|mine|add|del} [grupos]"
    exit 1
fi

ACTION="$1"
shift

case "$ACTION" in
    list)
        getent group
        ;;
    mine)
        groups "$CURRENT_USER"
        ;;
    add)
        if [ $# -lt 1 ]; then
            echo "Erro: indique pelo menos um grupo"
            exit 1
        fi

        for GROUP in "$@"; do
            if getent group "$GROUP" > /dev/null; then
                echo "A adicionar $CURRENT_USER ao grupo $GROUP"
                usermod -aG "$GROUP" "$CURRENT_USER"
            else
                echo "Erro: grupo '$GROUP' não existe"
            fi
        done
        ;;
    del)
        if [ $# -lt 1 ]; then
            echo "Erro: indique pelo menos um grupo"
            exit 1
        fi

        for GROUP in "$@"; do
            if getent group "$GROUP" > /dev/null; then
                echo "A remover $CURRENT_USER do grupo $GROUP"
                gpasswd -d "$CURRENT_USER" "$GROUP"
            else
                echo "Erro: grupo '$GROUP' não existe"
            fi
        done
        ;;
    *)
        echo "Uso: ./scriptGroups.sh {list|mine|add|del} [grupos]"
        exit 1
        ;;
esac
