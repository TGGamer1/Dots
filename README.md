<div align="center">
    <h1>【 Dots — Multi-Distro Bootstrap 】</h1>
    <h3></h3>
</div>

<div align="center">

![](https://img.shields.io/github/last-commit/TGGamer1/Dots?&style=for-the-badge&color=8ad7eb&logo=git&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/stars/TGGamer1/Dots?style=for-the-badge&logo=andela&color=86dbd7&logoColor=D9E0EE&labelColor=1E202B)
![](https://img.shields.io/github/repo-size/TGGamer1/Dots?color=86dbce&label=SIZE&logo=protondrive&style=for-the-badge&logoColor=D9E0EE&labelColor=1E202B)

</div>

<div align="center">
    <h2>• overview •</h2>
    <h3></h3>
</div>

<details> 
  <summary>Notable features</summary>
     
  - **Overview**: This repository automates setting up your terminal workflow and dotfiles across multiple Linux distributions.
  - **Distro Support**: It works on Arch, Debian/Ubuntu, Fedora, NixOS(No idea how it will behave), and even supports Brew and Flatpak.
  - **Transparent installation**: Every command is shown before it's run.
  - **Automatic setup**: with the `--auto` flag everything will be automatically installed and setup with proper symlinks using stow.
</details>
<details> 
  <summary>Installation</summary>

   - Just run 
   ```bash
   git clone https://github.com/TGGamer1/Dots.git ~/Dots
   cd ~/Dots
   ./bootstrap.sh
   ```
   - The name of the install script is `bootstrap.sh`.
</details>
<details>
  <summary>Repo overview</summary>
  
    Dots/
    ├── bootstrap.sh                # Main entry point, sources modular scripts
    ├── config                      # Contains files pointing to $HOME/.config
    │   ├── fish                    # Fish config files
    │   ├── foot                    # Foot config files
    │   ├── fuzzel                  # Fuzzel config files
    │   ├── hypr                    # Hyprland config files (For Arch, end-4's dots)
    │   └── kitty                   # Kitty config files
    ├── home                        # Contains files pointing to $HOME
    │   ├── .bashrc                 # Bash config
    │   ├── shellconf               # Alis and function files to be listed here
    │   │   └── alias
    │   └── .zshrc                  # Zsh config
    ├── pkgs
    │   ├── arch.txt                # Arch-specific packages
    │   ├── common.txt              # Packages installed on all distros
    │   ├── debian.txt              # Debian/Ubuntu-specific packages
    │   ├── fedora.txt              # Fedora-specific packages
    │   └── nix.txt                 # Nix package manager(Works in NixOS & w/o)
    └── scripts
        ├── install_flatpak.sh      # Installs Flatpak apps
        ├── install_pkgs.sh         # Package installation logic
        ├── setup_shell.sh          # Configures and sources your shell
        ├── stow_configs.sh         # Links dotfiles via stow
        └── update_system.sh        # Updates entire system


- Everything is writen in `bash`

- Note: Only top-level files are shown; each config folder contains multiple dotfiles.
</details>

**The user is advised to read the endire README.**

<div align="center">
    <h2>• usage •</h2>
    <h3></h3>
</div>

Run `bootstrap.sh` with `--auto` to automatically install packages and link configs.
Or use `--skip-update` with `--auto` to automatically install packages and link configs without updating the package repo(s) and your entire system

Open a new terminal for changes to take effect.

Alternately, In a POSIX-Compilant Shell: 
```
source bootstrap.sh
```
`Bash` is recommended by the developer as it is what he used, but `sh` can also be used.


**Optional:** Customize the pkgs/*.txt files to include the packages you want.

<div align="center">
    <h2>• notes •</h2>
    <h3></h3>
</div>

- The scripts should be sourced in the following order for proper setup:

  -  update_system.sh ( **WARNING** the setup may not function properly without it)

   -  install_pkgs.sh

  -   stow_configs.sh

   -  setup_shell.sh

   -  install_flatpak.sh

- For multi-user setups (like Nix), packages may need to be installed per-user.

- Scripts are to be run one at a time through bootstrap.sh. If the user wishes he may run them manually **but** it is not recommanded as it will break some things.

- **The user is expected to backup important files beforehand**

- The `home/shellconf/alias` file should be edited according to the user's liking, containing only `alias` definitions as it is sourced by `bash`, `zsh` and `fish` which use different syntax for functions.

- Oh-My-Zsh should be installed by the user prior to running `setup_shell.sh`.

<div align="center">
    <h3> Enjoy your setup! 🚀 </h3>
    <h4></h4>
</div>

<div align="center">

---

<h3>• inspirations/copying •</h3>

- This project was heavily inspired by <a href="https://github.com/end-4">end-4</a>’s legendary dotfile structure and their approach to transparent, idempotent setup scripts.

- Copying: Personally I have absolutely no problem with others redistributing/recreating my work. There's no "stealing" (maybe unless you loudly do weird stuff)

</div>

---

<h3></h3>

**P.S. The scripts were written on Arch Linux and haven’t yet been tested on other distros.**
