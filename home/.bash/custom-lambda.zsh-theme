local _path=$(pwd)

autoload -U add-zsh-hook
add-zsh-hook precmd _update_path

function _update_path() {
  _path=$(findroot)
}

function _get_path() {
  if [[ -z $_path ]]; then
    echo "${${PWD/#%$HOME/~}/#$HOME\//~/}"
  else
    local _subtracted="${_path%/*}"
    echo "${PWD#${_subtracted}/}"
  fi
}

function _get_caret_color() {
  local _caret="cyan"
  # Check if the user is as root
  if [[ $UID -eq 0 ]]; then 
    _caret="red"
  elif [[ -n $_path ]]; then
    _caret="green"
  fi
  echo $_caret
}

PROMPT='%{$fg[$(_get_caret_color)]%}λ%{$reset_color%} $(_get_path) %{$fg[$(_get_caret_color)]%}»%{$reset_color%} '
RPROMPT='$(vi_mode_prompt_info) $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[$(_get_caret_color)]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
