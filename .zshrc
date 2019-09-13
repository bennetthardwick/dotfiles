source $HOME/.bashrc

USER="bennett"
DEFAULT_USER=`whoami`

if [ -d "$HOME/.oh-my-zsh" ]; then
  ZSH=$HOME/.oh-my-zsh
else
  ZSH=/usr/share/oh-my-zsh/
fi

ZSH_THEME="agnoster"
DISABLE_AUTO_UPDATE="true"

plugins=(git)

export EDITOR="nvim"

alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

export VISUAL="nvim"
export SHELL="zsh"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/google-cloud-sdk"

stty -ixon

export CHROME_BIN=chromium

export NODE_OPTIONS=--max_old_space_size=16384

AUTO_SUGGEST=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -f "$AUTO_SUGGEST" ]
then
  source $AUTO_SUGGEST
else
  source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

export N_PREFIX="$HOME/.n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
