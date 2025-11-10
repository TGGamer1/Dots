# #!/usr/bin/env bash
# set -e
#
# log "Linking dotfiles via stow..."
#
# if ! command -v stow &>/dev/null; then
#     log "Stow not found — installing..."
#     install_packages "$PKG_DIR/common.txt" # Should include stow
# fi
#
# if [ ! -d home ]; then
#     warn "No home directories found — skipping."
# else
#     stow --verbose=1 -t ~ home
# fi
#
# if [ ! -d config ]; then
#     warn "Config dir not found — skipping."
# else
#     stow --verbose=1 -t ~/.config --ignore="hypr"

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
  stow --verbose=3 -t ~ home && stow --verbose=3 -t ~/.config config
fi

