# XDG Base Directory non-complient programs
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share

mkdir -p "$XDG_DATA_HOME"/less
export LESSHISTFILE="$XDG_DATA_HOME"/less/history

mkdir -p "$XDG_DATA_HOME"/bash
export HISTFILE="$XDG_DATA_HOME"/bash/history

mkdir -p "$XDG_DATA_HOME"/gdb
export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history

export MAILCAPS="$XDG_CONFIG_HOME"/mailcap

export VISUAL=nvim
export RUSTC_WRAPPER=sccache
[ -n "$BASH_VERSION" -a -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

[ -z "$WAYLAND_DISPLAY" -a "$(tty)" = '/dev/tty1' ] && exec sway
