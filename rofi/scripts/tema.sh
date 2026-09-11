#!/bin/bash
# LABEL: Terminal: Alternar Tema

if [ -z "$1" ]; then
    echo -e "Moderno\nRetro\n◀ Voltar"
    exit 0
fi

case "$1" in
    "Moderno")
        ln -sf ~/.Xresources.modern ~/.Xresources
        xrdb -load ~/.Xresources
        exit 0
        ;;
    "Retro")
        ln -sf ~/.Xresources.retro ~/.Xresources
        xrdb -load ~/.Xresources
        exit 0
        ;;
esac

exit 1
