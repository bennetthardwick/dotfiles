<p align="center">
  <img src="/.config/images/logo.png" width="300" alt="~/.dotfiles"></a>
</p>

---
<h1 align="center">dotfiles</h1>
<p align="center">
  The configuration files for Bennett's Arch Linux rice based around Gruvbox.
</p>

## Getting Started

In order to set up this rice you need to install Arch Linux and create a user. This can be done by following [the Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide).

Note: the automatic bootstrap script uses `sudo`, so you'll need to ensure your user is apart of the `wheel` group.

After installing everything and creating your user, clone the `dotfiles` repo to `~/git/dotfiles`.
```
mkdir -p ~/git
git clone git@github.com:bennetthardwick/dotfiles.git ~/git/dotfiles
```

After cloning the respository run the bootstrap script and follow the prompts.
```
~/git/bin/bootstrap-environment.sh
```

Once this script completes log back into your user to start Hyprland.

## Preview

![first](/.config/images/first.png)

![second](/.config/images/second.png)
