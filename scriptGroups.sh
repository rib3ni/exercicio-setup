#!/bin/bash

# Validação inicial
if [ "$#" -lt 1 ]; then
    echo "Uso: $0 {list|mine|add|del} [grupos]"
    exit 1
fi

ACTION="$1"
shift

case "$ACTION" in
    list)
        # Listar todos os grupos existentes
        cut -d: -f1 /etc/group
        ;;
    mine)
        # Listar grupos do utilizador atual
        groups
        ;;
    add|del)
        # Validação de grupos
        if [ "$#" -lt 1 ]; then
            echo "Erro: informe pelo menos um grupo"
            echo "Uso: $0 $ACTION grupo1 [grupo2 ...]"
            exit 1
        fi

        for GRUPO in "$@"; do
            echo "Operação '$ACTION' no grupo: $GRUPO"
        done
        ;;
    *)
        echo "Uso: $0 {list|mine|add|del} [grupos]"
        exit 1
        ;;
esac
