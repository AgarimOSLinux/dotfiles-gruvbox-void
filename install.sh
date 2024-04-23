#!/bin/bash



clear &&
echo -e "[$] > Welcome!" &&
echo -e "[$] > Installation will update your system" &&
echo -e "[$] > Installation will change Git config file" &&
echo -e "[$] > If you are OK with this, write your root password, else press CTRL+C" &&
echo -e "[$] > Continue?" &&
sudo clear &&



read -p "\n [$] > Enter name of user to change system rights for: " RIGHTS_USER



cd ./bootstrap &&
./hierarchy.sh &&



echo -e "\n[$] > Creating temporary environment shell variables...\n" &&
INST="sudo xbps-install" &&
GITHUB="git config --global" &&
function SERVICE() {
    local service_name="$@";
    sudo ln -sf /etc/sv/$service_name /var/service/
}
echo -e "\n[$] > Temporary environment shell variables successfully created!\n" &&
echo -e "\n[$] > Updating $RIGHTS_USER system rights...\n" &&
sudo usermod -aG audio,video,network,input,plugdev $RIGHTS_USER &&
echo -e "\n[$] > $RIGHTS_USER system rights successfully updated!\n" &&



echo -e "\n[$] > Updating system packages...\n" &&
$INST -Su &&
echo -e "\n[$] > System successfully updated!\n" &&



echo -e "\n[$] > Installing libraries, tools, programming languages and apps...\n" &&
$INST -Suyv void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree &&
$INST -Suyv linux linux-firmware linux-headers os-prober \
    mesa mesa-32bit glu glu-32bit vulkan-loader vulkan-loader-32bit \
    mesa-dri mesa-dri-32bit mesa-vulkan-radeon mesa-vaapi mesa-vdpau \
    swayfx swaybg Waybar xdg-desktop-portal-wlr tlp \
    opendoas dbus elogind pam_rundir dhcpcd chrony polkit openssl openssl-devel pipewire mako \
    zip unzip unrar tar xz p7zip atool udiskie scc \
    bash git curl wget scc NetworkManager \
    v4l2loopback wf-recorder \
    man-db man-pages man-pages-devel man-pages-posix \
    lua clang clang-tools-extra python3 fasm \
    lua-language-server gdb make python3-pip python3-wheel python3-requests pkg-config docker docker-compose \
    wezterm helix fzf stow telegram-desktop mpv \
    grimshot wl-clipboard handlr brightnessctl \
    bottom tree calc ufetch bat wireproxy wofi \
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
sudo modprobe v4l2loopback exclusive_caps=1 card_label=VirtualVideoDevice
echo -e "\n[$] > PAM initialized successfully!\n" &&



echo -e "\n[$] > Changing GRUB config...\n" &&
sudo os-prober &&
sudo grub-mkconfig -o /boot/grub/grub.cfg &&
echo -e "\n[$] > GRUB config changed successfully!\n" &&



echo -e "\n[$] > Ignoring 'sudo' package...\n" &&
sudo touch /usr/share/xbps.d/ignorepkgs.conf &&
echo "ignorepkg=sudo" | sudo tee -a /usr/share/xbps.d/ignorepkgs.conf &&
echo -e "\n[$] > Ignored successfully!\n" &&



echo -e "\n[$] > Creating symlinks...\n" &&
sudo ln -sf $HOME/.local/share/applications/open /usr/bin/xdg-open &&
sudo ln -sf /usr/bin/clang /usr/bin/cc &&
sudo ln -sf /usr/bin/clang /usr/bin/cxx &&
echo -e "\n[$] > Symlinks created successfully!\n" &&



echo -e "\n[$] > Stowing configuration files...\n" &&
sudo ln -sf /usr/share/fontconfig/conf.avail/70-yes-bitmaps.conf /etc/fonts/conf.d/ &&
sudo xbps-reconfigure -f fontconfig &&
rm -f $HOME/.bashrc &&
rm -f $HOME/.bash_profile &&
rm -f $HOME/.profile &&
./stower.sh &&
echo -e "\n[$] > Configuration files successfully stowed!\n" &&



echo -e "\n[$] > Removing 'sudo' package...\n" &&
sudo xbps-remove -Roy sudo &&
echo -e "\n[$] > Removed successfully!\n" &&



echo -e "[$] > Installation successfully completed!" &&
echo -e "[$] > You are able to use your system" &&
echo -e "[$] > Optionally, reboot the system to be sure for 100%" &&
echo -e "[$] > Goodbye!\n"
