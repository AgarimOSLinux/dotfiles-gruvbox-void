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
    device = "/dev/disk/by-uuid/badb5c4f-c6f4-4af9-8679-dbfa831b252c";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0FF7-40E8";
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
  environment.sessionVariables = {
    NIXOS_OZONE_ML = "1";
  };
  # {{ PROTOCOL }}

  # {{ APPS }}
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    # gui
    kitty firefox anydesk
    telegram-desktop
    wofi eww
    # net
    curl wget
    git atool
    # console
    bottom calc bunnyfetch
    helix bash stow
    # utils
    mako hyprpaper wl-clipboard
    shotman slurp
    # dev
    zig zls
    ghc haskellPackages.lsp
    gnumake clang clang-tools
    python3 python311Packages.python-lsp-server
  ];
  programs.mtr.enable = true;
  programs.gnupg.agent.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
  networking.firewall.enable = false;
  networking.useDHCP = lib.mkDefault true;
  networking.hostName = "asspain";
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
