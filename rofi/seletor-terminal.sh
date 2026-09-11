#!/bin/bash
if [ -z "$1" ]; then
    echo -e "Moderno\nRetro"
    exit 0
fi

case "$1" in
    "Moderno")
        ln -sf ~/.Xresources.modern ~/.Xresources
        xrdb -load ~/.Xresources
        ;;
    "Retro")
        ln -sf ~/.Xresources.retro ~/.Xresources
        xrdb -load ~/.Xresources
        ;;
esac
