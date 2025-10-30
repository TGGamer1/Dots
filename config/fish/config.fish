function fish_prompt -d "Write out the prompt"
    # This shows up as USER@HOST /home/user/ >, with the directory colored
    # $USER and $hostname are set by fish, so you can just use them
    # instead of using `whoami` and `hostname`
    printf '%s@%s %s%s%s > ' $USER $hostname \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

if status is-interactive # Commands to run in interactive sessions can go here

    # No greeting
    set fish_greeting

    # Use starship
    starship init fish | source
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    if test -f ~/.config/fish/alias.fish
        source ~/.config/fish/alias.fish
    end

    if test -f ~/Dots/home/shellconf/alias
        source ~/Dots/home/shellconf/alias
    end

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

    # Aliases
    alias pamcan='pacman'
    alias ls='eza --icons'
    alias clear="printf '\033[2J\033[3J\033[1;1H'"
    alias q='qs -c ii'

end
