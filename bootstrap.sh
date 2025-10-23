#!/usr/bin/env bash
# ===============================================
# T's Multi-Distro Bootstrap Script
# ===============================================

set -e

# Colors
green="\e[32m"
blue="\e[34m"
reset="\e[0m"

# Info prefix
info() {
    echo -e "${blue}[INFO]${reset} $1"
}

# Detect distro
if [ -f /etc/os-release ]; then
    . /etc/os-release
    distro=$ID
else
    distro="unknown"
fi

# Detect shell
shell_name=$(basename "$SHELL")

info "=== T's Multi-Distro Bootstrap ==="
info "Detected shell: $shell_name"
info "Detected distro: $distro"
echo

# Menu function
show_menu() {
    echo "1) Update System Packages             4) Setup Shell (setup_shell.sh)"
    echo "2) Install Packages (install_pkgs.sh) 5) Install Flatpaks (install_flatpak.sh)"
    echo "3) Stow Configs (stow_configs.sh)     6) Exit"
    echo
}

# Read choice safely (even when piped from curl)
read_choice() {
    if [ -t 0 ]; then
        read -rp "Choose what to run: " choice
    elif [ -e /dev/tty ]; then
        read -rp "Choose what to run: " choice </dev/tty
    else
        echo "[ERROR] Non-interactive shell detected. Exiting."
        exit 1
    fi
}

# Main loop
while true; do
    show_menu
    read_choice

    case "$choice" in
        1)
            info "Running update_system.sh..."
            bash ./scripts/update_system.sh || echo "[WARN] update_system.sh not found."
            ;;
        2)
            info "Running install_pkgs.sh..."
            bash ./scripts/install_pkgs.sh || echo "[WARN] install_pkgs.sh not found."
            ;;
        3)
            info "Running stow_configs.sh..."
            bash ./scripts/stow_configs.sh || echo "[WARN] stow_configs.sh not found."
            ;;
        4)
            info "Running setup_shell.sh..."
            bash ./scripts/setup_shell.sh || echo "[WARN] setup_shell.sh not found."
            ;;
        5)
            info "Running install_flatpak.sh..."
            bash ./scripts/install_flatpak.sh || echo "[WARN] install_flatpak.sh not found."
            ;;
        6)
            info "Exiting."
            exit 0
            ;;
        *)
            echo "[ERROR] Invalid choice."
            ;;
    esac

    echo
    info "Task completed. Returning to menu..."
    echo
done
