#!/usr/bin/env bash
set -e

# ─── Colors ───────────────────────────────
log()   { echo -e "\033[1;32m[INFO]\033[0m $1"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }
error() { echo -e "\033[1;31m[ERROR]\033[0m $1"; }

# ─── Vars ─────────────────────────────────
DOTFILES_DIR="$HOME/Dots"
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

# ─── Install packages ─────────────────────
install_packages() {
    local file="$1"
    [ ! -f "$file" ] && return

    while read -r pkg; do
        [[ -z "$pkg" || "$pkg" == \#* ]] && continue

        if [ "$DISTRO" = "arch" ]; then
            if command -v yay &>/dev/null; then
                yay -S --noconfirm "$pkg" && continue
            else
                sudo pacman -S --noconfirm "$pkg" && continue
            fi
        elif command -v apt &>/dev/null; then
            sudo apt install -y "$pkg" && continue
        elif command -v nix &>/dev/null; then
            nix profile install "$pkg" && continue
        elif command -v brew &>/dev/null; then
            brew install "$pkg" && continue
        elif command -v flatpak &>/dev/null; then
            flatpak install -y "$pkg" && continue
        else
            error "No supported package manager for $pkg"
        fi
    done < "$file"
}

# ─── Arch: install yay if missing ─────────
if [ "$DISTRO" = "arch" ]; then
    if ! command -v yay &>/dev/null; then
        log "Installing yay (AUR helper)..."
        sudo pacman -S --needed --noconfirm base-devel git
        tmpdir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay.git "$tmpdir"
        (cd "$tmpdir" && makepkg -si --noconfirm)
        rm -rf "$tmpdir"
    else
        log "yay already installed — skipping."
    fi
fi

# ─── Common & distro-specific installs ────
log "Installing common backup packages..."
install_packages "$PKG_DIR/common.txt"

if [ "$DISTRO" != "unknown" ]; then
    log "Installing distro-specific packages..."
    install_packages "$PKG_DIR/${DISTRO}.txt"
else
    warn "Unknown distro — skipping distro-specific packages."
fi

# ─── Stow configs ─────────────────────────
log "Linking dotfiles via stow..."
if ! command -v stow &>/dev/null; then
    log "Stow not found, installing..."
    install_packages "$PKG_DIR/common.txt" # should contain stow
fi

if [ ! -d home ] && [ ! -d config ]; then
    warn "No stow directories found (home/config) — skipping."
else
    stow -t ~ home config
fi

# ─── Source shell configs ─────────────────
log "Sourcing shell configs..."
case "$USER_SHELL" in
    fish)
        [ -f "$HOME/.config/fish/conf.d/00-source-all.fish" ] && source "$HOME/.config/fish/conf.d/00-source-all.fish"
        ;;
    zsh)
        [ -f "$HOME/.zshrc" ] && source "$HOME/.zshrc"
        ;;
    bash)
        [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc"
        ;;
    *)
        warn "Unknown shell — skipping shell sourcing."
        ;;
esac

log "🎉 Bootstrap complete! Open a new terminal to enjoy your full setup."