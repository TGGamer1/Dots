# Dots — Multi-Distro Bootstrap

This repository automates setting up your terminal workflow and dotfiles across multiple Linux distributions. It works on Arch, Debian/Ubuntu, Fedora, NixOS(No idea how it will behave), and even supports Brew and Flatpak.

**The User is advised to read the endire README.**

## Features

- Installs common and distro-specific packages
- Sets up your dotfiles via `stow`
- Configures your shell (Fish, Zsh, Bash)
- Installs Flatpak apps like Zen Browser
- Modular scripts for easy maintenance and customization

## Quick Start

Clone and run the bootstrap.sh form Github:

```bash
git clone https://github.com/TGGamer1/Dots.git ~/Dots
cd ~/Dots
./bootstrap.sh
```

⚠️ Make sure to read below if you want to customize package installations.

```bash
Dots/
├── home                     # Contains files pointing to $HOME
├── config                   # Contains files pointing to $HOME/.config
├── bootstrap.sh             # Main entry point, sources modular scripts
├── scripts/
│   ├── install_pkgs.sh      # Package installation logic
│   ├── stow_configs.sh      # Links dotfiles via stow
│   ├── setup_shell.sh       # Configures and sources your shell
│   └── install_flatpak.sh   # Installs Flatpak apps
└── pkgs/
    ├── common.txt           # Packages installed on all distros
    ├── arch.txt             # Arch-specific packages
    ├── debian.txt           # Debian/Ubuntu-specific packages
    ├── fedora.txt           # Fedora-specific packages
    └── nix.txt              # Nix package manager(Works in NixOS & w/o)

```

## Usage

Run `bootstrap.sh` with `--auto` to automatically install packages and link configs.
Or Use `--skip-update` to automatically install packages and link configs without updating the package repo(s) and your entire system

Open a new terminal for changes to take effect.

Alternately, In a Posix-Compilant Shell: 
```
$ source bootstrap.sh
```
`Bash` is recommanded by the developer as it is what he used, but `sh` can also be used.


**Optional:** Customize the pkgs/*.txt files to include the packages you want.

## Notes

The scripts should be sourced in the following order for proper setup:

1. *update_system.sh* ( **WARNING** the setup may not function properly without it)

2. *install_pkgs.sh*

3. *stow_configs.sh*

4. *setup_shell.sh*

5. *install_flatpak.sh*

For multi-user setups (like Nix), packages may need to be installed per-user.

Scripts are to be run one at a time through bootstrap.sh. If the user wishes he may run them indivisually

Enjoy your setup! 🚀