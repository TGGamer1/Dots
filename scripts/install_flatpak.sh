#!/usr/bin/env bash
set -e

run_cmd() {
    echo -e "\033[1;34m>>> $@\033[0m"
    "$@"
}

log "Ensuring Flatpak setup..."

if ! command -v flatpak &>/dev/null; then
    log "Flatpak not found — installing..."
    case "$DISTRO" in
        arch) yay -S --noconfirm flatpak ;;
        debian) sudo apt install -y flatpak ;;
        fedora) sudo dnf install -y flatpak ;;
        nix) nix profile install nixpkgs.flatpak ;;
        *) brew install flatpak ;;
    esac
fi

if ! flatpak remote-list | grep -q flathub; then
    log "Adding Flathub..."
    run_cmd flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

if ! flatpak list | grep -q io.github.zen_browser.zen; then
    log "Installing Zen Browser..."
    run_cmd flatpak install -y flathub io.github.zen_browser.zen
else
    log "Zen Browser already installed — skipping."
fi
