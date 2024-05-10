#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "[\$] > Nope, no root run!"
    exit
fi

if [ -n "$SUDO_COMMAND" ]; then
    ROOT_CMD=sudo
else
    ROOT_CMD=doas
fi

read -p "[\$] > Username (OS): " WORK_USER_NAME
read -p "[\$] > Username (GIT): " WORK_USER_NAME_GIT
read -p "[\$] > Email (GIT): " WORK_USER_EMAIL_GIT
sleep 3

#  █████  ██      ██  █████  ███████ ███████ ███████ 
# ██   ██ ██      ██ ██   ██ ██      ██      ██      
# ███████ ██      ██ ███████ ███████ █████   ███████ 
# ██   ██ ██      ██ ██   ██      ██ ██           ██ 
# ██   ██ ███████ ██ ██   ██ ███████ ███████ ███████ 

PKGS_INSTALL="$ROOT_CMD xbps-install"
PKGS_REMOVE="$ROOT_CMD xbps-remove"

# ██      ██ ███████ ████████ ███████ 
# ██      ██ ██         ██    ██      
# ██      ██ ███████    ██    ███████ 
# ██      ██      ██    ██         ██ 
# ███████ ██ ███████    ██    ███████ 

declare -a REPOS_PKGS=(
    void-repo-nonfree void-repo-multilib
    void-repo-multilib-nonfree
)

declare -a HARDWARE_PKGS=(
    # kernel
    linux linux-firmware linux-headers
    # gpu
    mesa mesa-32bit mesa-dri mesa-dri-32bit mesa-vaapi mesa-vdpau
    vulkan-loader vulkan-loader-32bit mesa-vulkan-radeon
    glu glu-32bit
    # cpu
    linux-firmware-amd
)

declare -a DEV_PKGS=(
    # languages
    clang python3
    # tools
    make cmake lldb
    clang-tools-extra
    patch libtool
    pkgconf autoconf automake
    python3-pip python3-wheel
    just
    # libraries
    libstdc++-devel libunwind-devel
    openssl-devel
    # manuals
    man-db man-pages-posix
    man-pages man-pages-devel
)

declare -a SYSTEM_PKGS=(
    # managers
    dbus elogind pam_rundir
    dumb_runtime_dir
    # policies
    polkit
    # time
    chrony
    # network
    dhcpcd
    # layers
    xdg-desktop-portal
    xdg-desktop-portal-wlr
    xdg-desktop-portal-gtk
    xdg-desktop-portal-kde
    # xdg
    xdg-utils xdg-user-dirs
    # secrets
    libsecret
)

declare -a DESKTOP_PKGS=(
    # compositor
    sway
    # background
    swaybg
    # lockscreen
    gtklock
    # picker
    fuzzel
    # screenshot
    grimshot
    # clipboard
    wl-clipboard
    # interfaces
    qt6-wayland qt5
    gtk+ gtk+3
    # sound
    pipewire
    # network
    NetworkManager
    # fonts
    noto-fonts-ttf-extra
    noto-fonts-emoji
    font-awesome
)

declare -a ENV_PKGS=(
    # terminal
    foot
    # editor
    helix
    # browser
    firefox
    # messenger
    telegram-desktop
    # virtualization
    docker docker-compose
    # vpn
    wireproxy
    # utilities
    coreutils findutils diffutils
    fzf stow bottom calc ufetch
    curl wget git-libsecret
)

declare -a PKGS_INSTALL_LIST=()

declare -a PKGS_REMOVE_LIST=(
    sudo nvi void-artwork
)

declare -a SERVICES_LIST=(
    dbus sshd tlp docker dhcpcd polkitd chronyd
    pipewire pipewire-pulse NetworkManager
)

# ██       ██████   ██████  ██  ██████ 
# ██      ██    ██ ██       ██ ██      
# ██      ██    ██ ██   ███ ██ ██      
# ██      ██    ██ ██    ██ ██ ██      
# ███████  ██████   ██████  ██  ██████ 

_service() {
    local service_name="$@";
    $ROOT_CMD ln -sf /etc/sv/$service_name /var/service/
}

services() {
    for i in "${SRVC_LIST[@]}"; do
        _service "$i"
    done

    echo "-session   optional   pam_rundir.so" | $ROOT_CMD tee -a /etc/pam.d/system-login
}

_packages() {
    PKGS_INSTALL_LIST+=("${HARDWARE_PKGS[@]}")
    PKGS_INSTALL_LIST+=("${DEV_PKGS[@]}")
    PKGS_INSTALL_LIST+=("${SYSTEM_PKGS[@]}")
    PKGS_INSTALL_LIST+=("${DESKTOP_PKGS[@]}")
    PKGS_INSTALL_LIST+=("${ENV_PKGS[@]}")

    $ROOT_CMD touch /usr/share/xbps.d/ignorepkgs.conf
    for pkg in "${PKGS_REMOVE_LIST[@]}"; do
        echo "ignorepkg=$pkg" | $ROOT_CMD tee -a /usr/share/xbps.d/ignorepkgs.conf
    done
}

packages() {
    _packages
    $PKGS_INSTALL -Su
    $PKGS_INSTALL -Suyv "${REPOS_PKGS[@]}"
    $PKGS_INSTALL -Suy "${PKGS_INSTALL_LIST[@]}"
    $PKGS_REMOVE -ROoy "${PKGS_REMOVE_LIST[@]}"
    curl https://raw.githubusercontent.com/tristanisham/zvm/master/install.sh | bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |\
        sh -s -- -y --profile complete --default-toolchain stable
}

rights() {
    $ROOT_CMD usermod -aG audio,video,network,input,plugdev "$WORK_USER_NAME"
}

credentials() {
    git config --global user.email "$WORK_USER_EMAIL_GIT"
    git config --global user.name "$WORK_USER_NAME_GIT"
}

hierarchy() {
    mkdir -p $HOME/.config/vpn
    mkdir -p $HOME/.local/share/fonts
    mkdir -p $HOME/.local/share/icons
    mkdir -p $HOME/.local/share/themes
    mkdir -p $HOME/.local/share/applications
    mkdir -p $HOME/.mozilla/firefox/main.main/extensions
    mkdir -p $HOME/.mozilla/firefox/main.main/chrome
}

stower() {
    rm -f $HOME/.bashrc
    rm -f $HOME/.bash_profile
    rm -f $HOME/.profile

    cd files/
    stow -t $HOME/ */
    fc-cache -f -v
    xdg-user-dirs-update
    firefox --ProfileManager
}

# ███    ███  █████  ██ ███    ██ 
# ████  ████ ██   ██ ██ ████   ██ 
# ██ ████ ██ ███████ ██ ██ ██  ██ 
# ██  ██  ██ ██   ██ ██ ██  ██ ██ 
# ██      ██ ██   ██ ██ ██   ████ 

main() {
    hierarchy
    rights
    packages
    services
    stower
}

main
