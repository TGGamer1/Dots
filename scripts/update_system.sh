#!/usr/bin/env bash
set -e

log()   { echo -e "\033[1;32m[INFO]\033[0m $1"; }
warn()  { echo -e "\033[1;33m[WARN]\033[0m $1"; }

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

log "Updating system packages for $DISTRO..."

case "$DISTRO" in
    arch)
        sudo pacman -Syu --noconfirm ;;
    debian)
        sudo apt update -y && sudo apt upgrade -y ;;
    fedora)
        sudo dnf update -y ;;
    nix)
        nix-channel --update && nix-env -u '*' ;;
    *)
        warn "Unknown distro — skipping system update." ;;
esac

log "System update complete!"
