#!/usr/bin/zsh

# Once you've cloned https://github.com/bennetthardwick/dotfiles to
# $HOME/git/dotfiles - run this script to install everything else.

set -e

printf "\nUpdating Arch\n\n"

sudo pacman -Syu --noconfirm

# Make the config folder so stowing everything doesn't just symlink the folder
mkdir -p $HOME/.config
mkdir -p $HOME/screenshots

# Sometimes there's a bashrc
rm -f $HOME/.bashrc

sudo pacman -S stow --noconfirm --needed

cd $HOME/git

printf "\nStowing Dotfiles\n\n"

stow dotfiles

echo "\nInstalling AUR Dependencies\n\n"

# Everything required to build from the AUR (if you didn't install base-devel)
sudo pacman -S --noconfirm neovim vim base-devel --needed

# Build all packages (opening the PKGBUILD for each one)
# To get peak performance from building AUR packages set the "jobs" flag on
# the build software to be around the number of threads you have.
# E.g.
# make -j24

aur oh-my-zsh-git
aur ttf-font-awesome-4

GRUVBOX_GTK_FOLDER=$HOME/.themes/Gruvbox/
GRUVBOX_GTK_ICON_FOLDER=$HOME/.icons/Gruvbox/

if [ ! -d "$GRUVBOX_GTK_FOLDER" ]
then
  git clone https://github.com/bennetthardwick/gruvbox-gtk.git --depth 1 $GRUVBOX_GTK_FOLDER
fi

if [ ! -d "$GRUVBOX_GTK_ICON_FOLDER" ]
then
  git clone https://github.com/bennetthardwick/gruvbox-icons-gtk.git --depth 1 $GRUVBOX_GTK_ICON_FOLDER
fi

echo "\nInstalling Dependencies\n\n"

sudo pacman -S --noconfirm --needed \
  openssh \
  htop \
  fzf \
  firefox \
  alacritty \
  zsh \
  zsh-autosuggestions \
  ripgrep \
  ttf-fantasque-sans-mono \
  ttf-fantasque-nerd \
  cantarell-fonts \
  ntp \
  pipewire \
  pipewire-audio \
  pipewire-alsa \
  pipewire-jack-client \
  pipewire-pulse \
  wireplumber \
  pavucontrol \
  bat \
  hyprland \
  xdg-desktop-portal-hyprland \
  wl-clipboard \
  waybar \
  brightnessctl \
  gammastep \
  bemenu-wayland \
  grim \
  slurp \
  swaylock

# Enable getting the time from the internet
systemctl enable --now ntpd

printf "\nOptional Dependencies. Press n to not install.\n\n"

sudo pacman -S --needed \
  noto-fonts-extra \
  noto-fonts \
  noto-fonts-emoji \
  noto-fonts-cjk \
  fcitx \
  fcitx-gtk3 \
  fcitx-mozc \
  fcitx-configtool || echo "Not installing optional dependencies"

# Get zsh environment variables
source $HOME/.zshrc || echo ""

printf "\nInstalling N (Node version manager) through curl script\n\n"
if [ ! -x "$(command -v n)" ]
then
  sed -i '/^export\ N_PREFIX/d' $HOME/git/dotfiles/.zshrc
  N_PREFIX=$HOME/.n/ curl -L https://git.io/n-install | bash /dev/stdin -n
  n lts
fi

printf "\nInstalling Rust through curl script\n\n"

if [ ! -x "$(command -v rustup)" ]
then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# Return home so new shells open at home
cd $HOME

echo "Install complete. Exit the shell and log back in to start the desktop environment."
echo ""
echo "Have fun! :)"
