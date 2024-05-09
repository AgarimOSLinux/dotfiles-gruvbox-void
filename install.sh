#!/bin/bash

#  █████  ██      ██  █████  ███████ ███████ ███████ 
# ██   ██ ██      ██ ██   ██ ██      ██      ██      
# ███████ ██      ██ ███████ ███████ █████   ███████ 
# ██   ██ ██      ██ ██   ██      ██ ██           ██ 
# ██   ██ ███████ ██ ██   ██ ███████ ███████ ███████ 

alias PKGS_INSTALL="xbps-install"
alias PKGS_REMOVE="xbps-remove"

# ██      ██ ███████ ████████ ███████ 
# ██      ██ ██         ██    ██      
# ██      ██ ███████    ██    ███████ 
# ██      ██      ██    ██         ██ 
# ███████ ██ ███████    ██    ███████ 

declare -ar REPOS_PKGS=(
    void-repo-nonfree void-repo-multilib
    void-repo-multilib-nonfree
)

declare -ar HARDWARE_PKGS=(
    # kernel
    linux linux-firmware linux-headers
    # gpu
    mesa mesa-32bit mesa-dri mesa-dri-32bit mesa-vaapi mesa-vdpau
    vulkan-loader vulkan-loader-32bit mesa-vulkan-radeon
    glu glu-32bit
    # cpu
    linux-firmware-amd
)

declare -ar DEV_PKGS=(
    # languages
    clang python3
    # tools
    make cmake lldb
    clang-tools-extra
    diff patch libtool
    pkgconf autoconf automake
    python3-pip python3-wheel
    # libraries
    libstdc++-devel libunwind-devel
    openssl-devel
    # manuals
    man-db man-pages-posix
    man-pages man-pages-devel
)

declare -ar SYSTEM_PKGS=(
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
)

declare -ar DESKTOP_PKGS=(
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
    # fonts
    noto-fonts-ttf-extra
    noto-fonts-emoji
)

declare -ar ENV_PKGS=(
    # terminal
    foot
    # editor
    helix
    # browser
    qutebrowser
    # messenger
    telegram-desktop
    # vpn
    wireproxy
    # utilities
    coreutils findutils diffutils
    fzf stow bottom calc ufetch
)

declare -ar PKGS_INSTALL_LIST=(
)

declare -ar PKGS_REMOVE_LIST=(
    sudo nvi void-artwork
)

declare -ar SERVICES_LIST=(
    dbus sshd tlp docker dhcpcd polkitd chronyd
    pipewire pipewire-pulse NetworkManager
)

# ██       ██████   ██████  ██  ██████ 
# ██      ██    ██ ██       ██ ██      
# ██      ██    ██ ██   ███ ██ ██      
# ██      ██    ██ ██    ██ ██ ██      
# ███████  ██████   ██████  ██  ██████ 

services() {
    for i in "${SRVC_LIST[@]}"; do
        _service "$i"
    done
}

_service() {
    local service_name="$@";
    sudo ln -sf /etc/sv/$service_name /var/service/
}

repositories() {
    PKGS_INSTALL -Su # update
    PKGS_INSTALL -Suyv # repos
    PKGS_INSTALL -Su # update
    PKGS_INSTALL -Suy # pkgs
}

_packages() {
    repositories
}

rights() {
    read -p "\n [$] > Enter name of user to change system rights for: " RIGHTS_USER
    echo -e "\n[$] > Updating $RIGHTS_USER system rights...\n"
    sudo usermod -aG audio,video,network,input,plugdev $RIGHTS_USER
    echo -e "\n[$] > $RIGHTS_USER system rights successfully updated!\n"
}

hierarchy() {
    echo -e "\n[$] > Creating folders hierarchy..."
    mkdir -p $HOME/.config/vpn
    mkdir -p $HOME/.config/firefox
    mkdir -p $HOME/.config/firefox/extensions
    mkdir -p $HOME/.local/share/fonts
    mkdir -p $HOME/.local/share/icons
    mkdir -p $HOME/.local/share/themes
    mkdir -p $HOME/.local/share/applications
    echo -e "\n[$] > Hierarchy created successfully!"
}

welcome() {
    clear
    echo -e "[$] > Welcome!"
    echo -e "[$] > Installation will update your system"
    echo -e "[$] > Installation will change Git config file"
    echo -e "[$] > If you are OK with this, write your root password, else press CTRL+C"
    echo -e "[$] > Continue?"
    sudo clear
}

# ███    ███  █████  ██ ███    ██ 
# ████  ████ ██   ██ ██ ████   ██ 
# ██ ████ ██ ███████ ██ ██ ██  ██ 
# ██  ██  ██ ██   ██ ██ ██  ██ ██ 
# ██      ██ ██   ██ ██ ██   ████ 

main() {
    welcome
    hierarchy
    rights
    packages
}

main

echo -e "\n[$] > Installing libraries, tools, programming languages and apps...\n" &&
$INST -Suyv linux linux-firmware linux-headers os-prober \
    mesa mesa-32bit glu glu-32bit vulkan-loader vulkan-loader-32bit \
    mesa-dri mesa-dri-32bit mesa-vulkan-radeon mesa-vaapi mesa-vdpau \
    sway swaybg yambar xdg-desktop-portal-wlr tlp \
    opendoas dbus elogind pam_rundir dhcpcd chrony polkit openssl openssl-devel pipewire mako \
    zip unzip unrar tar xz p7zip atool udiskie scc \
    bash git curl wget scc NetworkManager \
    man-db man-pages man-pages-devel man-pages-posix \
    lua gcc clang clang-tools-extra lldb python3 cmake libstdc++-devel \
    lua-language-server gdb make python3-pip python3-wheel python3-requests pkg-config docker docker-compose \
    libunwind-devel libtool \
    pkgconf \
    foot helix fzf stow telegram-desktop mpv \
    grimshot wl-clipboard xdg-utils brightnessctl \
    bottom coreutils autoconf automake calc ufetch bat wireproxy fuzzel \
    noto-fonts-emoji \
    qt6-wayland qt5 gtk+ gtk+3 \
    firefox zathura-pdf-mupdf &&
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |\
    sh -s -- -y --profile minimal --default-toolchain stable &&
source "$HOME/.cargo/env" &&
rustup component add rust-analyzer clippy rustfmt &&
cargo install asm-lsp &&
echo -e "\n[$] > Libraries, tools, programming languages and apps are succesfully installed!\n" &&



echo -e "\n[$] > Enabling services...\n" &&
SERVICE dbus &&
SERVICE sshd &&
SERVICE tlp &&
SERVICE docker &&
SERVICE dhcpcd &&
SERVICE polkitd &&
SERVICE chronyd &&
SERVICE pipewire &&
SERVICE pipewire-pulse &&
SERVICE NetworkManager &&
echo -e "\n[$] > Services enabled successfully!\n" &&



echo -e "\n[$] > Initializing PAM and mod probing virtual webcam...\n" &&
echo "-session   optional   pam_rundir.so" | sudo tee -a /etc/pam.d/system-login &&
echo -e "\n[$] > PAM initialized successfully!\n" &&



echo -e "\n[$] > Changing GRUB config...\n" &&
sudo os-prober &&
sudo grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\n[$] > GRUB config changed successfully!\n" &&



echo -e "\n[$] > Ignoring 'sudo' package...\n" &&
sudo touch /usr/share/xbps.d/ignorepkgs.conf &&
echo "ignorepkg=sudo" | sudo tee -a /usr/share/xbps.d/ignorepkgs.conf &&
echo "ignorepkg=nvi" | sudo tee -a /usr/share/xbps.d/ignorepkgs.conf &&
echo -e "\n[$] > Ignored successfully!\n" &&



echo -e "\n[$] > Stowing configuration files...\n" &&
sudo ln -sf /usr/share/fontconfig/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/ &&
sudo xbps-reconfigure -f fontconfig &&
rm -f $HOME/.bashrc &&
rm -f $HOME/.bash_profile &&
rm -f $HOME/.profile &&
./stower.sh &&
echo -e "\n[$] > Configuration files successfully stowed!\n" &&



echo -e "\n[$] > Removing 'sudo' package...\n" &&
sudo xbps-remove -Roy sudo nvi &&
echo -e "\n[$] > Removed successfully!\n" &&



echo -e "[$] > Installation successfully completed!" &&
echo -e "[$] > You are able to use your system" &&
echo -e "[$] > Optionally, reboot the system to be sure for 100%" &&
echo -e "[$] > Goodbye!\n"
