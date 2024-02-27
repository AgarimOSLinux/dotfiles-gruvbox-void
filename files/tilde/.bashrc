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
alias wifi="nmtui"
alias clip="wl-copy"
alias ls="ls --color"
alias ll="ls --color -lAh"
alias vpn="wireproxy -c $HOME/.config/vpn/stable.conf"
# {{ ALIASES }}



# {{ FUNCTIONS }}
function cd { command cd "$@"; ls; }
function clear { command clear; bunnyfetch; echo; ls; }

function bashclear {
    history -c && history -w
    clear
    printf "\n[$] > Bash history cleared.\n"
}

function nsync {
    local stamp="$(date +'%Y-%m-%d')"

    pushd $HOME/notes

    git add . &&
    git commit -m "[script] $stamp" &&
    git push

    popd
}

function nedit {
    local filepath=$(find $HOME/notes/ -not -path '*/.*' | fzf)
    hx "$filepath"
}

function gcl {
    git clone https://github.com/$1.git
}
# {{ FUNCTIONS }}



# {{ ON STARTUP }}
clear
# {{ ON STARTUP }}
