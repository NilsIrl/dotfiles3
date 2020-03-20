#!/usr/bin/env sh

pactl list sinks | grep no >/dev/null && pactl list sinks | grep '^[[:space:]]Volume:' | grep -o '[[:digit:]]*' | tail --lines +2 | head --lines 1 || echo 0
