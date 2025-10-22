# ----------------------------------------------------------------------------------
# NOTE: User configuration

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

## ----------------------------------------------------------------------------------
## NOTE: Aliases
#
#alias bashconf="nvim ~/.bashrc"
#alias zshconf="nvim ~/.zshrc"
#alias fishconf="nvim ~/.config/fish/config.fish"
#alias kittyconf="nvim ~/.config/kitty/kitty.conf"
#alias hyprconf="z ~/.config/hypr/hyprland"
#
#alias upgrade="sudo pacman -Syu"
#alias install="sudo pacman -S"
#alias remove="sudo pacman -R"
#
#alias history="atuin history list | bat"
#alias which="pacman -Ql"
#
#alias grep="rg"
#alias find="fd"
#alias cat="bat"
#alias ls="eza -lha --icons"
#alias tree="eza --tree --icons"
#alias cd="z"
#
# ----------------------------------------------------------------------------------
# NOTE: Eval and init things

# 🚀 Initialize tools
zoxide init fish | source
atuin init fish | source

# 🍃 Homebrew
if test -d /home/linuxbrew/.linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# 🧠 Node Version Manager (NVM)
set -x NVM_DIR $HOME/.nvm
if test -s "$NVM_DIR/nvm.sh"
    bass source $NVM_DIR/nvm.sh
end
if test -s "$NVM_DIR/bash_completion"
    bass source $NVM_DIR/bash_completion
end

# ----------------------------------------------------------------------------------
# FZF colors
set -x FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# ----------------------------------------------------------------------------------
