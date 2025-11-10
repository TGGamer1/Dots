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

function vz
    if test (count $argv) -eq 0
        echo "Usage: vz <dir>"
        return 1
    end

    set dir $argv[1]
    # Jump there with zoxide
    z $dir

    # Launch VS Code and Kitty in background
    code .
    kitty --detach &
end
