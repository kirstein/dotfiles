### Load bashrc
. ~/.bashrc

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.bash/oh-my-zsh

setopt hist_ignore_all_dups

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each # time that oh-my-zsh is loaded.
#
# Using custom theme! Will source it manually!
#ZSH_THEME="lambda"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
 #DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git-extras last-working-dir vi-mode)
bindkey -v
bindkey '^R' history-incremental-search-backward

source $ZSH/oh-my-zsh.sh

# Fuck off perl
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Customize to your needs...
export PATH=$PATH:/Library/Haskell/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:$HOME/bin:/usr/local/share/npm/bin:$HOME/.rbenv/bin:$HOME/.cabal/bin
export LANG="en_US.UTF-8"

# Go path settings
export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go

export PATH=$PATH:~/.bash/dasht/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Custom lambda template
source ~/.bash/custom-lambda.zsh-theme
source ~/.bash/zsh-autosuggestions/zsh-autosuggestions.zsh

# Automatically switch between node modules
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

export PATH="/usr/local/sbin:$PATH"
export EDITOR="vim"

export FZF_DEFAULT_COMMAND='ag -g ""'

[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

eval "$(fasd --init auto)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH="/home/linuxbrew/.linuxbrew/sbin:$PATH"
