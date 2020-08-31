#!/usr/bin/env sh

get_volume() {
	pactl list sinks | grep 'Mute: no' >/dev/null && pactl list sinks | grep '^[[:space:]]Volume:' | grep -o '[[:digit:]]*' | tail --lines +2 | head --lines 1 || echo 0
}

pactl subscribe | grep --line-buffered ' sink ' | while IFS= read -r; do volume=$(get_volume); echo $((volume > 100 ? 100 : volume)); done | wob
