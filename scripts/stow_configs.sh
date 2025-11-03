#!/usr/bin/env bash
set -e

log "Linking dotfiles via stow..."

if ! command -v stow &>/dev/null; then
    log "Stow not found — installing..."
    install_packages "$PKG_DIR/common.txt" # Should include stow
fi

if [ ! -d home ]; then
    warn "No stow directories found — skipping."
else
    stow --verbose=1 -t ~ home
fi

if [ ! -d config ]; then
    warn "Config dir not found — skipping."
else
    stow --verbose=1 -t ~/.config --ignore="hypr"

if [[ "$DISTRO" == "arch" ]]; then 
    run_cmd "Arch detected! Symlinking Hypr config..."
    stow --verbose=1 -d config -t ~/.config hypr
else
    run_cmd "Not Arch ($DISTRO), skipping Hypr config."
fi