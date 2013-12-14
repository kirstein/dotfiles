# Custom lambda theme
# Removes the current directory alias showing
# Since I use scm_breeze it was a freaking mess
PROMPT='%{$fg[cyan]%}λ%{$reset_color%} ${${PWD/#%$HOME/~}/#$HOME\//~/} '
RPROMPT='$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
