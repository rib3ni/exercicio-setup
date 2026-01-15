#!/bin/bash

ACTION="$1"
shift
case "$ACTION" in
list)
# lógica de listagem de grupos existentes
;;
mine)
# lógica de listagem dos meus grupos
;;
add|del)
# lógica de alteração de grupos
;;
*)
echo "Uso: $0 {list|mine|add|del} [grupos]"
exit 1
;;
esac
