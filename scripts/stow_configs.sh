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
    stow -t ~ home config --ignore=".gitconfig"
fi
