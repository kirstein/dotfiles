### Load z
. ~/.bash/z/z.sh

### Load bashrc
. ~/.bashrc

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.bash/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
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
 DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git git-extras bower brew npm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/Users/kirstein/.rvm/gems/ruby-2.0.0-p247/bin:/Users/kirstein/.rvm/gems/ruby-2.0.0-p247@global/bin:/Users/kirstein/.rvm/rubies/ruby-2.0.0-p247/bin:/Users/kirstein/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/kirstein/bin:/usr/local/share/npm/bin:/Users/kirstein/.rvm/bin:/Users/kirstein/.rvm/bin:/Users/kirstein/.rvm/bin:/Users/kirstein/.rvm/bin:/Users/kirstein/.rvm/bin

[ -s "/Users/kirstein/.scm_breeze/scm_breeze.sh" ] && source "/Users/kirstein/.scm_breeze/scm_breeze.sh"

source ~/.bash/custom-lambda.zsh-theme
