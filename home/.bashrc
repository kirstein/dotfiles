### Source global definitions (if any)
if [ -f /etc/bashrc ]; then
  # . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in $(find ~/.bash/ -mindepth 1 -maxdepth 1 -type f) ; do
  [[ -r $file ]] && source "$file"
done
