#!/usr/bin/env bash
set -e

# ─── Colors ───────────────────────────────
log()   { echo -e "\033[1;32m[INFO]\033[0m $1"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# ─── Vars ─────────────────────────────────
DOTFILES_DIR="$HOME/Dots"
SCRIPTS_DIR="$DOTFILES_DIR/scripts"
PKG_DIR="$DOTFILES_DIR/pkgs"

# ─── Clone repo if missing ────────────────
if [ ! -d "$DOTFILES_DIR" ]; then
    log "Dotfiles repo not found — cloning..."
    git clone https://github.com/TGGamer1/Dots.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

# ─── Detect shell ─────────────────────────
USER_SHELL=$(basename "$SHELL")
log "Detected shell: $USER_SHELL"

# ─── Detect distro ────────────────────────
if [ -f /etc/arch-release ]; then
    DISTRO="arch"
elif [ -f /etc/debian_version ]; then
    DISTRO="debian"
elif grep -q "Fedora" /etc/os-release 2>/dev/null; then
    DISTRO="fedora"
elif grep -q "NixOS" /etc/os-release 2>/dev/null; then
    DISTRO="nix"
else
    DISTRO="unknown"
fi
log "Detected distro: $DISTRO"

# ─── Source Scripts ───────────────────────
source "$SCRIPTS_DIR/install_pkgs.sh"
source "$SCRIPTS_DIR/stow_configs.sh"
source "$SCRIPTS_DIR/setup_shell.sh"
source "$SCRIPTS_DIR/install_flatpak.sh"

log "🎉 Bootstrap complete! Open a new terminal to enjoy your full setup."
