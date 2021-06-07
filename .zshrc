source $HOME/.bashrc

export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export CLOUDSDK_PYTHON=python2

# Start ssh-agent so that I can call ssh-add
eval $(ssh-agent) > /dev/null

USER="bennett"
DEFAULT_USER=`whoami`

ZSH_CUSTOM="$HOME/.config/zsh-custom"
if [ -d "$HOME/.oh-my-zsh" ]; then
  ZSH=$HOME/.oh-my-zsh
else
  ZSH=/usr/share/oh-my-zsh/
fi

ZSH_THEME="gitster"
DISABLE_AUTO_UPDATE="true"

plugins=(git)

export EDITOR="nvim"
export VISUAL="nvim"
export SHELL="zsh"

export FZF_PREVIEW_COMMAND="bat-preview {}"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

source /home/bennett/.ghcup/env

export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper_lazy.sh

export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/opt/google-cloud-sdk/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/bin"

export NPM_TOKEN=${NPM_TOKEN:-""}

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

fpath+=~/.zfunc

compinit -C

export N_PREFIX="$HOME/.n/"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# If this is started from tty1 then start X. This is a way to get around having
# a greeter. This should be the last thing to load so programs launched from i3
# have the correct PATH / environment variables set.
if [ "$(tty)" = "/dev/tty1" ]; then
    sx
    exit 0
fi

# Anything following this will only be sourced by shells

alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

# Stay in the same folder when exiting ranger
alias ranger='ranger --choosedir=$HOME/.rangerdir; cd "$(cat $HOME/.rangerdir)"'
alias udf="pushd ~/git/dotfiles && git pull --no-rebase && popd"
alias xcp="xclip -o -selection primary"
