#!/bin/bash
# LABEL: Monitor: Ajustar Layout

if [ -z "$1" ]; then
    echo -e "1. Espelhar\n2. Estender (Direita)\n3. Apenas Notebook\n◀ Voltar"
    exit 0
fi

INTERNA=$(xrandr | grep " connected" | grep -E "eDP|LVDS" | awk '{print $1}')
EXTERNA=$(xrandr | grep " connected" | grep -v "$INTERNA" | awk '{print $1}')

case "$1" in
    "1. Espelhar")
        [ -n "$EXTERNA" ] && xrandr --output "$INTERNA" --auto --output "$EXTERNA" --auto --same-as "$INTERNA"
        exit 0
        ;;
    "2. Estender (Direita)")
        [ -n "$EXTERNA" ] && xrandr --output "$INTERNA" --auto --output "$EXTERNA" --auto --right-of "$INTERNA"
        exit 0
        ;;
    "3. Apenas Notebook")
        [ -n "$EXTERNA" ] && xrandr --output "$EXTERNA" --off --output "$INTERNA" --auto
        exit 0
        ;;
esac

exit 1
