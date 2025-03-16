#!/usr/bin/env bash

# Once you've cloned https://github.com/bennetthardwick/dotfiles to
# $HOME/git/dotfiles - run this script to install everything else.

set -e

maybe_aur() {
 	if ! pacman -Q $1 2>1 > /dev/null; then
		aur $1
	fi
}

systemctl_enable() {
	if [ "$(systemctl is-enabled $1)" = "not-found" ]; then
		systemctl enable --now $1
	fi
}

echo ""
echo "Updating Arch"
echo ""

sudo pacman -Syu --noconfirm

# Make the config folder so stowing everything doesn't just symlink the folder
mkdir -p \
	$HOME/.config/ \
	$HOME/screenshots \
	$HOME/recordings/ \
	$HOME/notes/ \
	$HOME/Documents/ \
	$HOME/Downloads/ \
	$HOME/Documents/Synced/ \
	$HOME/Pictures/ \
	--

# Sometimes there's a bashrc
rm -f $HOME/.bashrc

sudo pacman -S stow --noconfirm --needed

cd $HOME/git

echo ""
echo "Stowing Dotfiles"

stow dotfiles

echo ""
echo "Installing AUR Dependencies"
echo ""

# Everything required to build from the AUR (if you didn't install base-devel)
sudo pacman -S --noconfirm neovim vim base-devel --needed

# Build all packages (opening the PKGBUILD for each one)
# To get peak performance from building AmayiUR packages set the "jobs" flag on
# the build software to be around the number of threads you have.
# E.g.
# make -j24

maybe_aur oh-my-zsh-git
maybe_aur ttf-font-awesome-4

GRUVBOX_GTK_FOLDER=$HOME/.themes/Gruvbox/
GRUVBOX_GTK_ICON_FOLDER=$HOME/.icons/Gruvbox/

echo ""
echo "Installing GTK theme."
echo ""

if [ ! -d "$GRUVBOX_GTK_FOLDER" ]; then
  git clone https://github.com/bennetthardwick/gruvbox-gtk.git --depth 1 $GRUVBOX_GTK_FOLDER
else
	echo "Not installing theme. Already installed."
fi

if [ ! -d "$GRUVBOX_GTK_ICON_FOLDER" ]; then
  git clone https://github.com/bennetthardwick/gruvbox-icons-gtk.git --depth 1 $GRUVBOX_GTK_ICON_FOLDER
else
	echo "Not installing icons. Already installed."
fi

gsettings set org.gnome.desktop.interface gtk-theme "Gruvbox"
gsettings set org.gnome.desktop.interface icon-theme "Gruvbox"

echo ""
echo "Installing Dependencies"
echo ""

sudo pacman -S --noconfirm --needed \
	alacritty \
	bat \
	bemenu-wayland \
	brightnessctl \
	cantarell-fonts \
	firefox \
	fzf \
	gammastep \
	grim \
	htop \
	hyprland \
	less \
	mako \
	ntp \
	openssh \
	pavucontrol \
	pipewire \
	pipewire-alsa \
	pipewire-audio \
	pipewire-jack-client \
	pipewire-pulse \
	ripgrep \
	slurp \
	swaylock \
	ttf-fantasque-nerd \
	ttf-fantasque-sans-mono \
	waybar \
	wireplumber \
	wl-clipboard \
	xdg-desktop-portal-hyprland \
	zsh \
	zsh-autosuggestions \
	--

# Enable getting the time from the internet
systemctl_enable ntpd

echo ""
echo "Optional Dependencies. Press n to not install."
echo ""

sudo pacman -S --needed \
  noto-fonts-extra \
  noto-fonts \
  noto-fonts-emoji \
  noto-fonts-cjk \
  fcitx \
  fcitx-gtk3 \
  fcitx-mozc \
  fcitx-configtool \
	-- || echo "Not installing optional dependencies"

# Get zsh environment variables
source $HOME/.zshrc

echo ""
echo "Installing N (Node version manager) through curl script"
echo ""

if [ ! -x "$(command -v n)" ]; then
  sed -i '/^export\ N_PREFIX/d' $HOME/git/dotfiles/.zshrc
  N_PREFIX=$HOME/.n/ curl -L https://git.io/n-install | bash /dev/stdin -n
  n lts
else
	echo "Skipping, already installed."
fi

echo ""
echo "Installing Rust through curl script"
echo ""

if [ ! -x "$(command -v rustup)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	# The above script adds this so get rid of it:
	sed -i '/^. "$HOME\/.cargo\/env"$/d' ~/.bashrc
else
	echo "Skipping, already installed."
fi

# Return home so new shells open at home
cd $HOME

echo ""
echo "Install complete."
echo ""
echo "Exit the shell and log back in to start the desktop environment."
echo ""
echo "Have fun! :)"
