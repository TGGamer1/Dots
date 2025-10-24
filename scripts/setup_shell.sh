#!/usr/bin/env bash
set -e

run_cmd() {
    echo -e "\033[1;34m>>> $@\033[0m"
    "$@"
}

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
2