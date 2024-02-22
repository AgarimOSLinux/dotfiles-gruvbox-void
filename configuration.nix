{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  # {{ BOOT }}
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # {{ BOOT }}

  # {{ FILESYSTEM }}
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7341951a-b379-40b4-b32e-4c327d8e0b25";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D410-78DA";
    fsType = "vfat";
  };
  swapDevices = [ ];
  # {{ FILESYSTEM }}

  # {{ LOCALISATION }}
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  # {{ LOCALISATION }}

  # {{ PROTOCOL }}
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # {{ PROTOCOL }}

  # {{ ENV }}
  environment.sessionVariables = {
    GDK_SCALE = "2";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_ENABLE_HIDPI_SCALING = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_ML = "1";
    SDL_VIDEODRIVER = "wayland";
  };
  # {{ ENV }}

  # {{ APPS }}
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # gui
    kitty anydesk
    telegram-desktop eww
    # net
    curl wget atool wireproxy
    # console
    bottom calc bunnyfetch
    helix bash stow fzf
    # utils
    mako hyprpaper wl-clipboard
    shotman slurp brightnessctl
    # dev
    zig zls
    ghc haskellPackages.lsp
    gnumake clang clang-tools
    python3 python311Packages.python-lsp-server
  ];
  programs.git = {
    enable = true;
#    extraConfig = {
#      credential.helper = "${
#        pkgs.git.override { withLibsecret = true; }
#      }/bin/git-credential-libsecret";
#    };
#    aliases = {
#      ci = "commit";
#      co = "checkout";
#      p = "pull";
#      s = "status";
#    };
#    userName = "fidelicura";
#    userEmail = "fidelicura@gmail.com";
  };
  services.dbus.enable = true;
  programs.firefox.enable = true;
  programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "fidelicura" ];
    keepEnv = true;
    persist = true;
  }];
  virtualisation.docker.enable = true;
  # {{ APPS }}

  # {{ SOUND }}
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  # {{ SOUND }}

  # {{ NETWORK }}
  networking.hostName = "asspain";
  networking.firewall.enable = false;
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
  # {{ NETWORK }}

  # {{ CPU }}
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # {{ CPU }}

  # {{ GPU }}
  hardware = {
    opengl.enable = true;
  };
  # {{ GPU }}
  
  # {{ USERS }}
  users.users.fidelicura = {
    isNormalUser = true;
    extraGroups = [ "audio" "video" "input" "networkmanager" ];
  };
  # {{ USERS }}

  # {{ SYSTEM }}
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "23.11";
  system.copySystemConfiguration = true;
  # {{ SYSTEM }}
}
