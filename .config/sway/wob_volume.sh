#!/usr/bin/env sh

pactl subscribe | grep --line-buffered ' sink ' | while IFS= read -r; do volume=`~/.config/sway/get_volume.sh`; echo $(($volume > 100 ? 100 : $volume)); done | wob
