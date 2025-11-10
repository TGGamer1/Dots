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
