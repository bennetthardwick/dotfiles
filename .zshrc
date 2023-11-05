source $HOME/.bashrc
export GPG_TTY=$(tty)

export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export GPG_TTY=$(tty)

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
export SHELL="/usr/bin/zsh"

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

safe_source /opt/miniconda3/etc/profile.d/conda.sh


export WORKON_HOME=~/.virtualenvs
safe_source /usr/bin/virtualenvwrapper_lazy.sh

export PATH="/usr/lib:/usr/bin:/bin"

export PATH="$HOME/.yarn/bin:$PATH"

safe_source /home/bennett/.ghcup/env

export PNPM_HOME="/home/bennett/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export N_PREFIX="$HOME/.n/"
export PATH="$N_PREFIX/bin:$PATH"

safe_source /home/bennett/.cargo/env

safe_source /home/bennett/.asdf/asdf.sh

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"


# if type "asdf" > /dev/null; then
#   # Fix cargo install path if using asdf
#   if asdf which cargo 2> /dev/null > /dev/null; then
#     export PATH="$PATH:$(dirname $(asdf which cargo))"
#   fi
# fi

export NPM_TOKEN=${NPM_TOKEN:-""}

stty -ixon

export CHROME_BIN=chromium

export NODE_OPTIONS=--max_old_space_size=16384

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

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

# export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export PIPEWIRE_LATENCY="256/48000"

export GTK_THEME="Gruvbox"

# If this is started from tty1 then start X. This is a way to get around having
# a greeter. This should be the last thing to load so programs launched from i3
# have the correct PATH / environment variables set.
if [ "$(tty)" = "/dev/tty1" ]; then
  if type "Hyprland" > /dev/null; then
    export XDG_CURRENT_DESKTOP=hyprland
    export MOZ_ENABLE_WAYLAND=1

    Hyprland 2> /tmp/hyprland.log
    exit 0
  elif type "sway" > /dev/null; then
    export XDG_CURRENT_DESKTOP=sway
    export MOZ_ENABLE_WAYLAND=1

    sway -d 2> /tmp/sway.log
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


uzip() {
  unzip $1 -d ${1%.zip}
}
