#!/usr/bin/env bash
set -e

log "Sourcing shell configs..."

case "$USER_SHELL" in
    fish)
        [ -f "$HOME/.config/fish/config.fish" ] && source "$HOME/.config/fish/config.fish"
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
