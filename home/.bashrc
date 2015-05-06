### Source global definitions (if any)
if [ -f /etc/bashrc ]; then
  # . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

export HISTCONTROL=ignoreboth
# After each command, save and reload history
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you donât want to commit.
for file in $(find ~/.bash/ -mindepth 1 -maxdepth 1 -type f) ; do
  [[ -r $file ]] && source "$file"
done
