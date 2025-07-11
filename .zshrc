safe_source() {
	if [ -f "$1" ]; then
		source $1
	fi
}

safe_source_zsh() {
	if [ -z "${BASH:-}" ]; then
		safe_source $1
	else
		echo "Running from bash. Not sourcing '$1'."
	fi
}

safe_source $HOME/.bashrc

export LANG=en_AU.UTF-8
export LC_ALL=en_AU.UTF-8
export GPG_TTY=$(tty)

if [ -f "/usr/lib/seahorse/ssh-askpass" ]; then
	export SSH_ASKPASS="/usr/lib/seahorse/ssh-askpass"
	export SSH_ASKPASS_REQUIRE=prefer
fi

if [ "$(uname -s)" != "Darwin" ]; then
	if type "keychain" >/dev/null; then
		eval "$(keychain --timeout 10 --quick --quiet --eval)"
	elif type "ssh-agent" >/dev/null; then
		eval $(ssh-agent) >/dev/null
	else
		echo "warning: ssh-agent not started"
	fi
fi

USER="bennett"
DEFAULT_USER=$(whoami)

ZSH_CUSTOM="$HOME/.config/zsh-custom"

if [ -d "$HOME/.oh-my-zsh" ]; then
	ZSH=$HOME/.oh-my-zsh
else
	ZSH=/usr/share/oh-my-zsh/
fi

ZSH_THEME="gitster"
DISABLE_AUTO_UPDATE="true"

export EDITOR="nvim"
export VISUAL="nvim"
export SHELL="$(which zsh)"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh

if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir -p $ZSH_CACHE_DIR
fi

safe_source_zsh $ZSH/oh-my-zsh.sh

safe_source /opt/miniconda3/etc/profile.d/conda.sh

export WORKON_HOME=~/.virtualenvs
safe_source /usr/bin/virtualenvwrapper_lazy.sh

export PATH="/usr/lib:/usr/bin:/bin:/sbin"

export PATH="/usr/bin/vendor_perl/:/usr/bin/core_perl/:$PATH"

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

safe_source $HOME/.ghcup/env

export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

export N_PREFIX="$HOME/.n/"
export PATH="$N_PREFIX/bin:$PATH"

safe_source $HOME/.cargo/env
# ~/.cargo/env might not exist depending on how rustup
export PATH="$HOME/.cargo/bin:$PATH"

safe_source $HOME/.asdf/asdf.sh

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.local/opt/google-cloud-sdk/" ]; then
	source "$HOME/.local/opt/google-cloud-sdk/completion.zsh.inc"
	source "$HOME/.local/opt/google-cloud-sdk/path.zsh.inc"
fi

if [ -d "/opt/google-cloud-cli/bin/" ]; then
	export PATH="/opt/google-cloud-cli/bin/:$PATH"
fi

if [ -f "/opt/homebrew/bin/brew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

# On Mac if LLVM was installed using brew then use that instead of the system
if [ -d "/opt/homebrew/opt/llvm/" ]; then
	export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
	export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
	export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
fi

export NPM_TOKEN=${NPM_TOKEN:-""}

stty -ixon

export CHROME_BIN=chromium

export NODE_OPTIONS=--max_old_space_size=16384

ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)

AUTO_SUGGEST=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
AUTO_SUGGEST_BREW=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ -f "$AUTO_SUGGEST" ]; then
	safe_source_zsh "$AUTO_SUGGEST"
elif [ -f "$AUTO_SUGGEST_BREW" ]; then
	safe_source_zsh "$AUTO_SUGGEST_BREW"
else
	safe_source_zsh "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# Include functions in the `.zfunc` folder
fpath+=~/.zfunc

if type "compinit" 2>1 >/dev/null; then
	compinit -C
fi

if type "zoxide" 2>1 >/dev/null; then
	eval "$(zoxide init zsh)"
	alias cd="z"
fi

if type "fzf" 2>1 >/dev/null; then
	source <(fzf --zsh)
fi

# export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export PIPEWIRE_LATENCY="256/48000"

export GTK_THEME="Gruvbox:dark"
export BROWSER="open-link"

# If this is started from tty1 then start the display server / window manager.
#
# This is a better alternative to having a greeter and means that the window manager
# will be run as the current user instead of root. It also means applications spawned by
# the window manager will have the PATH and other config in this file set.
if [ "$(tty)" = "/dev/tty1" ]; then
	if false; then
		exit 1
	elif type "Hyprland" >/dev/null; then
		# export XDG_CURRENT_DESKTOP=hyprland
		export MOZ_ENABLE_WAYLAND=1
		export ANKI_WAYLAND=1

		Hyprland 2>/tmp/hyprland.log
		exit 0
	elif type "sway" >/dev/null; then
		export XDG_CURRENT_DESKTOP=sway
		export MOZ_ENABLE_WAYLAND=1
		export ANKI_WAYLAND=1

		sway -d 2>/tmp/sway.log
		exit 0
	elif type "sx" >/dev/null; then
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
alias gti=git

uzip() {
	unzip $1 -d ${1%.zip}
}

tzip() {
	directory="$(mktemp --directory)"
	unzip "$1" -d "$directory"
	cd $directory
}
