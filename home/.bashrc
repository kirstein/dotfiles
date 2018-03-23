export HISTCONTROL=ignoreboth
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Load the shell dotfiles, and then some:
. ~/.bash/aliases
. ~/.bash/functions
