#!/bin/bash

# 1. ¿Hay audio o video reproduciéndose? (YouTube, VLC, Spotify)
if playerctl status 2>/dev/null | grep -q "Playing"; then
    exit 0
fi

# 2. ¿Están corriendo procesos críticos de desarrollo o servidores?
# Añadí procesos que sueles usar como Unity y Node
PROCESOS=("Unity" "node" "npm" "smbd" "rsync")

for p in "${PROCESOS[@]}"; do
    if pgrep -x "$p" > /dev/null; then
        exit 0
    fi
done

# 3. Si nada de lo anterior se cumple, bloqueamos
hyprlock