#!/bin/sh

IMG="${HYPR_WALLPAPER:-$HOME/media/images/background_images/test.jpg}"

if [ ! -f "$IMG" ]; then
    exit 0
fi

if ! command -v awww >/dev/null 2>&1; then
    exit 0
fi

pkill hyprpaper 2>/dev/null || true

if ! pgrep -x awww-daemon >/dev/null 2>&1; then
    awww-daemon --quiet --no-cache >/dev/null 2>&1 &
    sleep 0.5
fi

awww img --transition-type none --resize crop "$IMG"
