#!/usr/bin/env bash
set -e

# Colorful command runner
run_cmd() {
    echo -e "\033[1;34m>>> $@\033[0m"
    "$@"
}

log "Installing common packages..."

install_packages() {
    local file="$1"
    [ ! -f "$file" ] && return

    local pkgs_str
    pkgs_str=$(grep -vE '^\s*#|^\s*$' "$file" | tr '\n' ' ')
    local pkgs=($pkgs_str)

    [ "${#pkgs[@]}" -eq 0 ] && { log "No packages in $file"; return; }

    case "$DISTRO" in
        arch)
            if command -v yay &>/dev/null; then
                log "Installing via yay: ${pkgs[*]}"
                yay -S --noconfirm "${pkgs[@]}"
            else
                log "Installing via pacman: ${pkgs[*]}"
                sudo pacman -S --noconfirm "${pkgs[@]}"
            fi
            ;;
        debian)
            log "Installing via apt: ${pkgs[*]}"
            sudo apt install -y "${pkgs[@]}"
            ;;
        fedora)
            log "Installing via dnf: ${pkgs[*]}"
            sudo dnf install -y "${pkgs[@]}"
            ;;
        nix)
            log "Installing via nix: ${pkgs[*]}"
            local nixpkgs_args=()
            for pkg in "${pkgs[@]}"; do
                nixpkgs_args+=("nixpkgs.$pkg")
            done
            nix profile install -iA "${nixpkgs_args[@]}"
            ;;
        *)
            if command -v brew &>/dev/null; then
                log "Installing via brew: ${pkgs[*]}"
                brew install "${pkgs[@]}"
            elif command -v flatpak &>/dev/null; then
                log "Installing via flatpak: ${pkgs[*]}"
                flatpak install -y "${pkgs[@]}"
            else
                error "No supported package manager"
            fi
            ;;
    esac
}

# Arch: install yay if missing
if [ "$DISTRO" = "arch" ] && ! command -v yay &>/dev/null; then
    log "Installing yay (AUR helper)..."
    run_cmd sudo pacman -S --needed --noconfirm base-devel git
    tmpdir=$(mktemp -d)
    run_cmd git clone https://aur.archlinux.org/yay.git "$tmpdir"
    (cd "$tmpdir" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
fi

# Install packages
run_cmd install_packages "$PKG_DIR/common.txt"
run_cmd install_packages "$PKG_DIR/${DISTRO}.txt"
