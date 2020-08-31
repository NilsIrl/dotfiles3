# XDG Base Directory non-compliant programs
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_HOME=~/.local/share

mkdir -p "$XDG_DATA_HOME"/less
export LESSHISTFILE="$XDG_DATA_HOME"/less/history

mkdir -p "$XDG_DATA_HOME"/bash
export HISTFILE="$XDG_DATA_HOME"/bash/history

mkdir -p "$XDG_DATA_HOME"/gdb
export GDBHISTFILE="$XDG_DATA_HOME"/gdb/history

export MAILCAPS="$XDG_CONFIG_HOME"/mailcap

export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass

export VISUAL=nvim
export RUSTC_WRAPPER=sccache

export PATH="$HOME/.cargo/bin:$PATH"

export LIBGL_ALWAYS_SOFTWARE=1

[ -n "$BASH_VERSION" -a -f "$HOME"/.bashrc ] && . "$HOME"/.bashrc

[ -z "$WAYLAND_DISPLAY" -a "$(tty)" = '/dev/tty1' ] && exec sway
