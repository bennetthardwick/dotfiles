source $HOME/.bashrc

export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export CLOUDSDK_PYTHON=python2

# Start ssh-agent so that I can call ssh-add
if type "ssh-agent" > /dev/null; then
  eval $(ssh-agent) > /dev/null
else
  echo "warning: ssh-agent not started"
fi

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

safe_source() {
  if [ -f "$1" ]; then
   source $1
  fi
}

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir -p $ZSH_CACHE_DIR
fi

safe_source $ZSH/oh-my-zsh.sh

safe_source /home/bennett/.ghcup/env
safe_source /home/bennett/.cargo/env

safe_source /home/bennett/.asdf/asdf.sh

export WORKON_HOME=~/.virtualenvs
safe_source /usr/bin/virtualenvwrapper_lazy.sh

export N_PREFIX="$HOME/.n/"

export PATH="$PATH:$HOME/.cabal/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.7.0/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:/opt/google-cloud-sdk/bin"
export PATH="$PATH:$HOME/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$N_PREFIX/bin:$PATH"
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
  safe_source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

fpath+=~/.zfunc

if type "compinit" > /dev/null; then
  compinit -C
fi

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# If this is started from tty1 then start X. This is a way to get around having
# a greeter. This should be the last thing to load so programs launched from i3
# have the correct PATH / environment variables set.
if [ "$(tty)" = "/dev/tty1" ]; then
  if type "sway" > /dev/null; then
    export XDG_CURRENT_DESKTOP=sway
    sway
    exit 0
  elif type "sx" > /dev/null; then
    sx
    exit 0
  else
    echo "warning: sx is not installed"
  fi
fi

# Anything following this will only be sourced by shells


# Aliases

alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"

alias udf="pushd ~/git/dotfiles && git pull --no-rebase && popd"
alias xcp="xclip -o -selection primary"
alias joplin="joplin --profile ~/.config/joplin-desktop"
