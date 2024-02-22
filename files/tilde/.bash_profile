# {{ TTY }}
if [[ "$(tty)" == "/dev/tty1" ]]; then
    exec Hyprland
fi
# {{ TTY }}



# {{ CUSTOM }}
export TERM=xterm-256color
export EDITOR=hx
export VISUAL=hx

export CC=clang
export CXX=clang
# {{ CUSTOM }}



# {{ XDG }}
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_CONFIG_DIRS=/etc/xdg

export XDG_DESKTOP_DIR=$HOME/downloads
export XDG_DOCUMENTS_DIR=$HOME/downloads
export XDG_DOWNLOAD_DIR=$HOME/downloads
export XDG_PUBLICSHARE_DIR=$HOME/downloads
export XDG_TEMPLATES_DIR=$HOME/downloads
export XDG_MUSIC_DIR=$HOME/documents/music
export XDG_PICTURES_DIR=$HOME/documents/pictures
export XDG_VIDEOS_DIR=$HOME/documents/videos
# {{ XDG }}
