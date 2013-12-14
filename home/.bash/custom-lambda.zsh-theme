# Custom lambda theme
# Removes the current directory alias showing
# Since I use scm_breeze it was a freaking mess
# Also changed colors to make it look red, who doesn't like red?!
PROMPT='%{$fg[red]%}λ%{$reset_color%} ${${PWD/#%$HOME/~}/#$HOME\//~/} $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
