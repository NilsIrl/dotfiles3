HISTSIZE=
HISTFILESIZE=

PROMPT_DIRTRIM=2
# If there's no newline at the end of a command, add one and print newline symbol
PROMPT_COMMAND='printf "⏎%$((COLUMNS-1))s\\r"'

alias gdb="gdb --quiet -nh --command \"$XDG_CONFIG_HOME\"/.gdbinit"
alias mbsync="mbsync -c \"$XDG_CONFIG_HOME\"/isync/mbsyncrc"
