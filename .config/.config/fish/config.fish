if type -q nvim
    alias vim "nvim"
end
if type -q rg
    alias grep "rg"
end
if type -q bat
    alias cat "bat"
end

alias ls 'ls --color=auto'
alias ll 'ls -alF'
alias la 'ls -A'
alias grep "grep --color=auto"
alias diff "diff --color=auto"
alias vim "nvim"

# I really hate typing short words
alias v "vim"
alias g "git"
alias G "git"
alias c "clear"


# Use ^c for vi editing, bind ^x to interrupts instead
fish_vi_key_bindings
stty intr ^x

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/jordan/anaconda3/bin/conda
    eval /home/jordan/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/jordan/anaconda3/etc/fish/conf.d/conda.fish"
        . "/home/jordan/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/jordan/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# Immediately drop into tmux
if status is-interactive
and not set -q TMUX
    exec tmux
end
