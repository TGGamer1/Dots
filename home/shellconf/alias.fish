# ─── User configuration ─────────────────────────────────────────────────────── 
# Add to MANPATH
set -x MANPATH /usr/local/man $MANPATH

# Language environment
set -x LANG en_US.UTF-8

# Preferred editor (based on SSH or local)
if set -q SSH_CONNECTION
    set -x EDITOR vim
else
    set -x EDITOR nvim
end

# ─── Eval and init things ─────────────────────────────────────────────────────
# Initialize tools
zoxide init fish | source
atuin init fish | source

# Homebrew
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Node Version Manager (NVM)
set -x NVM_DIR $HOME/.nvm
if test -s "$NVM_DIR/nvm.sh"
    bass source $NVM_DIR/nvm.sh
end
if test -s "$NVM_DIR/bash_completion"
    bass source $NVM_DIR/bash_completion
end

# ──── NOTE: Aliases for Fish ──────────────────────────────────────────────────
# For editing configs
alias bashconf="nvim ~/.bashrc"
alias zshconf="nvim ~/.zshrc"
alias fishconf="nvim ~/.config/fish/config.fish"
alias kittyconf="nvim ~/.config/kitty/kitty.conf"
alias hyprconf="z ~/.config/hypr/hyprland"

# Distro-specific pkg management
alias upgrade="yay -Syu"
alias install="yay -S --needed --noconfirm"
alias remove="yay -R"
alias pamcan='pacman'

# Some shell-commands replaced by better ones
alias history="atuin history list | bat"
alias which="yay -Qln" # Always use grep or rg
alias clear="printf '\033[2J\033[3J\033[1;1H'"

alias ffetch="fastfetch --config hypr"

# Modern Replacement for old stuff
alias grep="rg"
alias cat="bat"
alias ls="eza -lha --git --icons --color=always --group-directories-first"
alias tree="eza --tree --icons --color=always --git"
alias cd="z"
alias q='qs -c ii'

# ─── Functions ────────────────────────────────────────────────────────────────
# Better use of eza
function ll
    if test (count $argv) -eq 0
        set argv .
    end
    # Try eza first, fallback to ls
    eza -lha --git --icons --color=always --group-directories-first $argv 2>/dev/null || ls -lha --color=always $argv
end

# 🚀 Warp Gate / Portal Function
function portal
    # Use zoxide directory history for fuzzy selection
    set dir (zoxide query -l | fzf \
        --height=100% \
        --border=rounded \
        --reverse \
        --info=inline \
        --preview 'eza -lha --git --icons --color=always --group-directories-first {} 2>/dev/null || ls -lha --color=always {}'
    )
    # If a directory was selected, cd into it
    if test -n "$dir"
        cd "$dir"
        clear
        echo "🌀 Welcome to (basename $dir)"
    end
end

# ─── Fzf colors ───────────────────────────────────────────────────────────────
set -x FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'