# XDG Base Directory non-complient programs
XDG_CONFIG_HOME=$HOME/.config
XDG_DATA_HOME=$HOME/.local/share
mkdir -p "$XDG_DATA_HOME"/less
export LESSHISTFILE="$XDG_DATA_HOME"/less/history
mkdir -p "$XDG_DATA_HOME"/bash
export HISTFILE="$XDG_DATA_HOME"/bash/history

export VISUAL=nvim
