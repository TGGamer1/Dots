# Dots — Multi-Distro Bootstrap

This repository automates setting up your terminal workflow and dotfiles across multiple Linux distributions. It works on Arch, Debian/Ubuntu, Fedora, NixOS, and even supports Brew and Flatpak.

## Features

- Installs common and distro-specific packages
- Sets up your dotfiles via `stow`
- Configures your shell (Fish, Zsh, Bash)
- Installs Flatpak apps like Zen Browser
- Modular scripts for easy maintenance

## Quick Start

Run the bootstrap script directly from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/TGGamer1/Dots/main/bootstrap.sh | bash
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
    └── nix.txt              # Nix/Brew packages

```

## Usage

**Optional:** Customize your pkgs/*.txt files to include the packages you want.

Run bootstrap.sh to automatically install packages and link configs.

Open a new terminal for changes to take effect.

Alternately, In a Posix-Compilant Shell 
```
source bootstrap.sh
```

## Notes

The scripts should be sourced in the following order for proper setup:

1. install_pkgs.sh

2. stow_configs.sh

3. setup_shell.sh

4. install_flatpak.sh

For multi-user setups (like Nix), packages may need to be installed per-user.

Enjoy your setup! 🚀
