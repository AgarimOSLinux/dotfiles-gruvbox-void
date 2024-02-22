# {{ INTERACTIVE }}
[[ $- != *i* ]] && return
# {{ INTERACTIVE }}



# {{ PROMPT }}
PS1="\n[#] \w [>] "
# {{ PROMPT }}



# {{ VARIABLES }}
source ~/.bash_profile
# {{ VARIABLES }}



# {{ ALIASES }}
alias h="hx"
alias py="python3"
alias ls="ls --color"
alias ll="ls --color -lAh"
alias xdg-open="handlr open"
alias xclip="xclip -selection c"
alias presenterm="presenterm --theme terminal-dark"
alias vpn="wireproxy -c $HOME/.config/vpn/stable.conf"
# {{ ALIASES }}



# {{ FUNCTIONS }}
function cd() { command cd "$@"; ls; }
function clear() { command clear; ufetch; echo; ls; }

function bashclear() {
    history -c && history -w
    clear
    printf "\n[$] > Bash history cleared.\n"
}

function nsync() {
    local stamp="$(date +'%Y-%m-%d')"

    pushd $HOME/documents/notes

    git add . &&
    git commit -m "[script] $stamp" &&
    git push

    popd
}

function nedit() {
    local filepath=$(find $HOME/documents/notes/content/ -not -path '*/.*' | fzf)
    hx "$filepath"
}

function doc() {
    local args="$@"
    man "$args" | bat
}
# {{ FUNCTIONS }}



# {{ ON STARTUP }}
clear
# {{ ON STARTUP }}
. "$HOME/.cargo/env"