# Check if the user is as root
if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="cyan"; fi

PROMPT='%{$fg[$CARETCOLOR]%}λ%{$reset_color%} ${${PWD/#%$HOME/~}/#$HOME\//~/} %{$fg[$CARETCOLOR]%}»%{$reset_color%} '
RPROMPT='$(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$CARETCOLOR]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
