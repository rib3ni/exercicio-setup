
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

        ;;
    mine)
        ;;
    add)
        if [ $# -lt 1 ]; then
            echo "Erro: indique pelo menos um grupo"
            exit 1
        fi

        CURRENT_USER=$(whoami)

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

        CURRENT_USER=$(whoami)

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
