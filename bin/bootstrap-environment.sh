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

GRUVBOX_GTK_FOLDER=$HOME/.themes/gruvbox-gtk/

if [ ! -d "$GRUVBOX_GTK_FOLDER" ]
then
  git clone https://github.com/bennetthardwick/gruvbox-gtk.git --depth 1 $GRUVBOX_GTK_FOLDER
fi


if [ ! -d "$HOME/git/gruvbox-arc-icon-theme/" ]
then
  cd $HOME/git/
  git clone https://github.com/bennetthardwick/gruvbox-arc-icon-theme --depth 1 gruvbox-arc-icon-theme
  cd gruvbox-arc-icon-theme
  ./autogen.sh --prefix=/usr
  sudo make install
fi

echo "\nInstalling Dependencies\n\n"

# For some reason i3 is already installed by this point.
# This will fail the next step so just use `yes`.
yes | sudo pacman -S i3-gaps

sudo pacman -S --noconfirm --needed \
  neovim \
  openssh \
  htop \
  the_silver_searcher \
  fzf \
  chromium \
  alacritty \
  zsh \
  zsh-autosuggestions \
  ripgrep \
  ttf-fantasque-sans-mono \
  cantarell-fonts \
  ntp \
  pulseaudio \
  pavucontrol \
  bat

# Install sway / wayland stuff
sudo pacman -S --noconfirm --needed \
  sway \
  wl-clipboard \
  waybar \
  brightnessctl \
  gammastep \
  bemenu-wayland \
  grim \
  scrub \
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

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Return home so new shells open at home
cd $HOME

if [[ $(tty) == /dev/tty* ]]; then
  sx
fi
