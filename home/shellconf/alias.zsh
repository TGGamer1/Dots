# ─── NOTE: User configuration ─────────────────────────────────────────────────
# ManPath
export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# ─── Functions ────────────────────────────────────────────────────────────────
portal() {
  local dir
  dir=$(zoxide query -l | fzf \
    --prompt="🚪 Enter Portal > " \
    --border=rounded \
    --ansi \
    --height=100% \
    --reverse \
    --info=inline \
    --layout=reverse-list \
    --preview 'eza -lha --git --icons --color=always --group-directories-first {} 2>/dev/null || ls -lha --color=always {}' \
  ) || return

  [ -n "$dir" ] && cd "$dir" && clear && echo "🌀 Welcome to "$dir""
}

# ─── Alias ────────────────────────────────────────────────────────────────────
# For editing configs
alias bashconf="nvim ~/.bashrc"
alias zshconf="nvim ~/.zshrc"
alias fishconf="nvim ~/.config/fish/config.fish"
alias kittyconf="nvim ~/.config/kitty/kitty.conf"
alias hyprconf="z ~/.config/hypr/hyprland"
alias aliasconf="nvim ~/shellconf/alias/zsh"

# Distro-specific pkg management
alias upgrade="yay -Syu"
alias install="yay -S --needed --noconfirm"
alias remove="yay -R"
alias pamcan='pacman'

# Some shell-commands replaced by better ones
alias history="atuin history list | bat"
alias which="yay -Qln" # Always pipe through grep or rg
alias clear="printf '\033[2J\033[3J\033[1;1H'"
alias ll='eza -lha --git --icons --color=always --group-directories-first 2>/dev/null || ls -lha --color=always {}'

# Modern Replacement for old stuff
alias grep="rg"
alias cat="bat"
alias ls="eza -lha --git --icons --color=always --group-directories-first"
alias tree="eza --tree --icons --color=always --git"
alias cd="z"
alias q='qs -c ii'

# ─── eval and source things ───────────────────────────────────────────────────

eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

source /usr/share/nvm/init-nvm.sh
source ~/shellconf/alias.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ─── Fzf colours ──────────────────────────────────────────────────────────────
export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
