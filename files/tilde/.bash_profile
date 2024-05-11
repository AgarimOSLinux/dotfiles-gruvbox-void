# {{ CUSTOM }}
export TERM=foot
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
# {{ WAYLAND }}



# {{ PATH }}
export PATH=$XDG_DATA_HOME/applications:$PATH
# {{ PATH }}



# {{ LANGUAGES }}
. "$HOME/.cargo/env"

export ZVM_INSTALL="$HOME/.zvm/self"
export PATH="$PATH:$HOME/.zvm/bin"
export PATH="$PATH:$ZVM_INSTALL/"
# {{ LANGUAGES }}



# {{ TTY }}
if [[ "$(tty)" == "/dev/tty1" ]]; then
    dbus-run-session sway
fi
# {{ TTY }}
