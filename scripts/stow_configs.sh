#!/usr/bin/env bash
set -e

log "Linking dotfiles via stow..."

if ! command -v stow &>/dev/null; then
    log "Stow not found — installing..."
    install_packages "$PKG_DIR/common.txt" # Should include stow
fi

if [ ! -d home ] && [ ! -d config ]; then
    warn "No stow directories found — skipping."
else
    stow --verbose=1 -t ~ home config --ignore="hypr"
fi

if [[ "$DISTRO"=="arch" ]]; then 
    run_cmd "Arch detected! Symlinking Hypr config..."
    stow --verbose=1 -d config -t ~ hypr
else
    run_cmd "Not Arch ($DISTRO), skipping Hypr config."
fi