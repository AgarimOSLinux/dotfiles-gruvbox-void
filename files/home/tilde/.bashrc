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
# {{ VARIABLES }}



# {{ ALIASES }}
alias py="python3"
alias ls="ls --color"
alias ll="ls --color -lAh"
alias bye="doas shutdown -P now"
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

    pushd $HOME/personal

    git add . &&
    git commit -m "[script] $stamp" &&
    git push

    popd
}

function nedit() {
    local filepath=$(find $HOME/personal -not -path '*/.*' | fzf)
    hx "$filepath"
}

function share() {
    wf-recorder --muxer=v4l2 --codec=rawvideo --file=/dev/video2 -x yuv420p
}
# {{ FUNCTIONS }}



# {{ ON STARTUP }}
clear
# {{ ON STARTUP }}
. "$HOME/.cargo/env"
