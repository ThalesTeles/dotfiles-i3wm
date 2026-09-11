#!/bin/bash
DIR="$HOME/.config/rofi/scripts"

label_de() {
    grep -m1 '^# LABEL:' "$1" | sed 's/^# LABEL: *//'
}

# Aba recém-aberta: lista os nomes de cada script
if [ -z "$1" ]; then
    for script in "$DIR"/*.sh; do
        label_de "$script"
    done
    exit 0
fi

# Voltar ao topo
if [ "$1" = "◀ Voltar" ]; then
    "$0"
    exit 0
fi

# Tenta achar quem é dono dessa opção
for script in "$DIR"/*.sh; do
    if [ "$1" = "$(label_de "$script")" ]; then
        "$script"          # é um nome de topo -> mostra o submenu dele
        exit 0
    fi
    if "$script" "$1"; then    # tenta como opção final de algum submenu
        exit 0
    fi
done
