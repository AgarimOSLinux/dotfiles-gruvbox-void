# {{ INTERACTIVE }}
[[ $- != *i* ]] && return

complete -cf doas
complete -cf man
# {{ INTERACTIVE }}



# {{ PROMPT }}
PS1="\n[#] \w [>] "
# {{ PROMPT }}



# {{ VARIABLES }}
source ~/.bash_profile
source ~/.bash_aliases
# {{ VARIABLES }}



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

    pushd $HOME/Documents/Personal

    git add . &&
    git commit -m "[script] $stamp" &&
    git push

    popd
}

function nedit() {
    local filepath=$(find $HOME/Documents/Personal -not -path '*/.*' | fzf)
    hx "$filepath"
}
# {{ FUNCTIONS }}



# {{ ON STARTUP }}
clear
. "$HOME/.cargo/env"
# {{ ON STARTUP }}
