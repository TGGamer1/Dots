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
AUTO_MODE=false
SKIP_UPDATE=false

# ─── Parse args ───────────────────────────
while [[ $# -gt 0 ]]; do
    case "$1" in
        --auto) AUTO_MODE=true ;;
        --skip-update) SKIP_UPDATE=true ;;
        *) warn "Unknown option: $1" ;;
    esac
    shift
done

# ─── Clone repo if missing ────────────────
if [ ! -d "$DOTFILES_DIR" ]; then
    log "Dotfiles repo not found — cloning..."
    git clone https://github.com/TGGamer1/Dots.git "$DOTFILES_DIR"
fi
cd "$DOTFILES_DIR"

# ─── Detect shell ─────────────────────────
USER_SHELL=$(basename "$SHELL")

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

# ─── Script Runner ────────────────────────
run_script() {
    local script_name="$1"
    local script_path="$SCRIPTS_DIR/$script_name"

    if [ ! -f "$script_path" ]; then
        warn "$script_name not found, skipping."
        return
    fi

    if $AUTO_MODE; then
        log "Running $script_name..."
        source "$script_path"
    else
        read -p "Run $script_name? [Y/n] " choice
        case "$choice" in
            [nN]*) log "Skipping $script_name";;
            *) log "Running $script_name..."; source "$script_path";;
        esac
    fi
    echo
}

# ─── Menu (Manual Mode) ───────────────────
show_menu() {
    log "=== T's Multi-Distro Bootstrap ==="
    log "Detected shell: $USER_SHELL"
    log "Detected distro: $DISTRO"
    echo

    options=(
        "Update System Packages"
        "Install Packages (install_pkgs.sh)"
        "Stow Configs (stow_configs.sh)"
        "Setup Shell (setup_shell.sh)"
        "Install Flatpaks (install_flatpak.sh)"
        "Exit"
    )

    PS3=$'\nChoose what to run: '
    select opt in "${options[@]}"; do
        case "$opt" in
            "Update System Packages") run_script "update_system.sh" ;;
            *install_pkgs.sh*)       run_script "install_pkgs.sh" ;;
            *stow_configs.sh*)       run_script "stow_configs.sh" ;;
            *setup_shell.sh*)        run_script "setup_shell.sh" ;;
            *install_flatpak.sh*)    run_script "install_flatpak.sh" ;;
            "Exit") log "Goodbye!"; break ;;
            *) warn "Invalid choice."; ;;
        esac
    done
}

# ─── Auto Mode ────────────────────────────
if $AUTO_MODE; then
    if ! $SKIP_UPDATE; then
        update_system
    else
        log "Skipping system update as requested."
    fi

    run_script "update_system.sh"
    run_script "install_pkgs.sh"
    run_script "stow_configs.sh"
    run_script "setup_shell.sh"
    run_script "install_flatpak.sh"
    log "Bootstrap complete ✅"
else
    show_menu
fi
