### Load bashrc
. ~/.bashrc

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.bash/oh-my-zsh

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
plugins=(git git-extras last-working-dir z vi-mode)
bindkey -v
bindkey '^R' history-incremental-search-backward

source $ZSH/oh-my-zsh.sh

# Fuck off perl
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

# Customize to your needs...
export PATH=$PATH:/Library/Haskell/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/Users/kirstein/.rbenv/bin:/Users/kirstein/.cabal/bin
export LANG="en_US.UTF-8"

# Go path settings
export PATH=$PATH:$GOPATH/bin
export GOPATH=$HOME/go

. "$(brew --prefix nvm)/nvm.sh"

# Custom lambda template
source ~/.bash/custom-lambda.zsh-theme

# Automatically switch between node modules
function chpwd() {
  if [ -r $PWD/.nvmrc ]; then
    nvm use `cat $PWD/.nvmrc`
  fi
}

export PATH="/usr/local/sbin:$PATH"
export EDITOR="vim"
export NPM_TOKEN=$(sed -n 's/.*authToken=//p' ~/.npmrc)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# export PATH="$HOME/.rbenv/bin:$PATH"

[ -s "/Users/kirstein/.scm_breeze/scm_breeze.sh" ] && source "/Users/kirstein/.scm_breeze/scm_breeze.sh"
alias wh=whaley
eval "$(docker-machine env default)"
[ -s "/Users/kirstein/workspace/github/testlio/testlio-toolbox/whaley.sh" ] && source "/Users/kirstein/workspace/github/testlio/testlio-toolbox/whaley.sh"
