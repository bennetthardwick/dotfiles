<p align="center">
  <img src="/.config/images/logo.png" width="300" alt="~/.dotfiles"></a>
</p>

---
<h1 align="center">dotfiles</h1>
<p align="center">
  The configuration files for Bennett's Arch Linux rice based around Gruvbox.
</p>

+ __GTK theme:__ [gruvbox-gtk](https://github.com/bennetthardwick/gruvbox-gtk)
+ __launcher:__ [rofi](https://github.com/davatorium/rofi)
+ __terminal:__ [alacritty](https://github.com/alacritty/alacritty) + zsh + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
+ __bar:__ [polybar](https://github.com/polybar/polybar)
+ __screenshot:__ [maim](https://github.com/naelstrof/maim)
+ __browser:__ chromium

## Dependencies
There are various dependencies that are required to get this rice working perfectly. Most are in the Arch repos but you will need to install some stuff form the AUR. If you're setting this rice up on another distro just install the same applications with the equivalent commands.

```
sudo pacman -S \
        i3-gaps \
        rofi \
        the_silver_searcher \
        fzf \
        maim \
        chromium \
        alacritty \
        zsh \
        zsh-autosuggestions \
        ripgrep \
        dunst \
        ranger \
        picom \
        hsetroot \
        redshift
```
In addition to this, you also need to install:
- [gruvbox-gtk](https://github.com/bennetthardwick/gruvbox-gtk)
- [neovim-nightly](https://aur.archlinux.org/packages/neovim-nightly/)
- [polybar](https://aur.archlinux.org/packages/polybar)
- [i3lock-fancy-rapid](https://aur.archlinux.org/packages/i3lock-fancy-rapid-git)

## Getting Started
To set up this rice you need to clone the `dotfiles` repo. When setting up my environment I like to create a folder called `git` in which I store everything.
```
mkdir -p ~/git
git clone git@github.com:bennetthardwick/dotfiles.git ~/git/dotfiles
```
After cloning the repo, symlink all the files to your home directory using the command `stow`.
```
cd ~/git
stow dotfiles
```
Now that the config files are stowed, the environment should be up and running.

## Preview
![first](/.config/images/first.png)
![second](/.config/images/second.png)
![third](/.config/images/third.png)
