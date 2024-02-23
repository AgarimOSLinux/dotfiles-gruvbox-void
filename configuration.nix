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
    kitty anydesk waybar
    telegram-desktop zathura
    # net
    curl wget wireproxy
    # archivers
    rar zip
    unrar unzip
    gnutar xz
    atool scc
    # console
    bottom calc bunnyfetch
    helix bash stow fzf
    # utils
    mako hyprpaper wl-clipboard
    shotman slurp brightnessctl
    # dev
    gdb
    zig zls
    ghc haskellPackages.lsp
    gnumake clang clang-tools
    (python311.withPackages(ps: with ps; [
      python-lsp-server wheel requests
    ]))
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
  let
    lock-false = {};
    lock-true = {};
  in
    {
      programs.firefox = {
        enable = true;
        languagePacks = [ "en-US", "ru" ];
        ExtensionSettings = {
          "*".installation_mode = "blocked";
          # ublock
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            insallation_mode = "force_installed";
          };
          # adblock
          "adblockultimate@adblockultimate.net.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/adblocker-ultimate/latest.xpi";
            insallation_mode = "force_installed";
          };
          # privacy badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };
          # duckduckgo privacy extension
          "jid1-ZAdIEUB7XOzOJw@jetpack.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/duckduckgo-for-firefox/latest.xpi";
            installation_mode = "force_installed";
          };
          # ghostery
          "firefox@ghostery.com.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
            installation_mode = "force_installed";
          };
          # clearurls
          "{74145f27-f039-47ce-a470-a662b129930a}.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
            installation_mode = "force_installed";
          };
          # stylus
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}.xpi" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
            installation_mode = "force_installed";
          };
          # EXTENSION TEMPLATE
          # "EXTENSION_HASH" = {
          #   install_url = "https://addons.mozilla.org/firefox/downloads/latest/EXTENSION_NAME/latest.xpi";
          #   insallation_mode = "force_installed";
          # };
        };
        Preferences = {
          x
        };
      };
    };
  };
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
