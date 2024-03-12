# {{ CUSTOM }}
export TERM=xterm-256color
export EDITOR=hx
export VISUAL=hx

export CC=clang
export CXX=clang
# {{ CUSTOM }}



# {{ WAYLAND }}
export LIBSEAT_BACKEND=logind

export GDK_SCALE=1
export GDK_BACKEND=wayland

export QT_QPA_PLATFORM=wayland-egl
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_ENABLE_HIDPI_SCALING=1

export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

export ELM_SCALE=1
export ELM_DISPLAY=wl

export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1

export XKB_DEFAULT_LAYOUT=us
export XKB_CURSORSIZE=36
# {{ WAYLAND }}



# {{ XDG }}
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR=/run/user/$(id -u)
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



# {{ PATH }}
export PATH=$XDG_DATA_HOME/applications/zig:$XDG_DATA_HOME/applications/zls/bin:$PATH
# {{ PATH }}



# {{ TTY }}
if [[ "$(tty)" == "/dev/tty1" ]]; then
    dbus-run-session sway
fi
# {{ TTY }}
