#!/usr/bin/env sh

pactl list sinks | grep no >/dev/null && pactl list sinks | grep '^[[:space:]]Volume:' | grep -o '[[:digit:]]*' | tail -n+2 | head -n1 || echo 0
