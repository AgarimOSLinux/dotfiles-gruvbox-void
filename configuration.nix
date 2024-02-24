{ config, lib, pkgs, modulesPath, ... }

:{
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
    GDK_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_ENABLE_HIDPI_SCALING = "1";
    ELM_SCALE = "2";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = "48";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_ML = "1";
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
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
  };
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "fidelicura" ];
    keepEnv = true;
    persist = true;
  }];
  virtualisation.docker.enable = true;
  programs.firefox.enable = true;
  # programs.firefox = {
  #   enable = true;
  #   languagePacks = [ "en-US" "ru" ];
    # profiles.fidelicura = {
    #   bookmarks = { };
    #   extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #     ublock-origin
    #     adblocker-ultimate
    #     privacy-badger
    #     duckduckgo-for-firefox
    #     ghostery
    #     clearurls
    #     styl-us
    #   ];
    #   extraConfig = {
    #     "layout.css.grid-template-masonry-value.enabled" = true;
    #     "dom.enable_web_task_scheduling" = true;
    #     "layout.css.has-selector.enabled" = true;
    #     "dom.security.sanitizer.enabled" = true;
    #     "browser.cache.disk.enable" = false;
    #     "network.http.pacing.requests.enabled" = false;
    #     "network.dns.disablePrefetch" = true;
    #     "browser.urlbar.speculativeConnect.enabled" = false;
    #     "browser.places.speculativeConnect.enabled" = false;
    #     "network.prefetch-next" = false;
    #     "network.predictor.enabled" = false;
    #     "network.predictor.enable-prefetch" = false;
    #     "privacy.partition.bloburl_per_partition_key" = true;
    #     "browser.uitour.enabled" = false;
    #     "privacy.globalprivacycontrol.enabled" = true;
    #     "privacy.globalprivacycontrol.functionality.enabled" = true;
    #     "privacy.trackingprotection.enabled" =	true;
    #     "privacy.trackingprotection.pbmode.enabled" = true;
    #     "privacy.donottrackheader.enabled" = true;
    #     "privacy.resistFingerprinting" = true;
    #     "security.remote_settings.crlite_filters.enabled" = true;
    #     "security.ssl.treat_unsafe_negotiation_as_broken" = true;
    #     "browser.xul.error_pages.expert_bad_cert" = true;
    #     "security.tls.enable_0rtt_data" = false;
    #     "browser.privatebrowsing.forceMediaMemoryCache" = true;
    #     "privacy.history.custom" = true;
    #     "browser.search.separatePrivateDefault.ui.enabled" = true;
    #     "browser.urlbar.update2.engineAliasRefresh" = true;
    #     "browser.search.suggest.enabled" = false;
    #     "browser.urlbar.suggest.quicksuggest.sponsored" = false;
    #     "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
    #     "browser.formfill.enable" = false;
    #     "security.insecure_connection_text.enabled" = true;
    #     "security.insecure_connection_text.pbmode.enabled" = true;
    #     "network.IDN_show_punycode" = true;
    #     "services.sync.prefs.sync.layout.spellcheckDefault" = false;
    #     "services.sync.prefs.sync.spellchecker.dictionary" = false;
    #     "dom.security.https_first" = true;
    #     "dom.security.https_only_mode" = true;
    #     "signon.rememberSignons" = false;
    #     "editor.truncate_user_pastes" = false;
    #     "extensions.formautofill.addresses.enabled" = false;
    #     "extensions.formautofill.creditCards.enabled" = false;
    #     "security.mixed_content.block_display_content" = true;
    #     "pdfjs.enableScripting" = false;
    #     "extensions.postDownloadThirdPartyPrompt" = false;
    #     "privacy.userContext.ui.enabled" = true;
    #     "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
    #     "media.peerconnection.ice.default_address_only" = true;
    #     "browser.safebrowsing.downloads.remote.enabled" = false;
    #     "identity.fxaccounts.enabled" = false;
    #     "browser.tabs.firefox-view" = false;
    #     "geo.enabled" = false;
    #     "toolkit.telemetry.unified" = false;
    #     "toolkit.telemetry.enabled" = false;
    #     "toolkit.telemetry.archive.enabled" = false;
    #     "toolkit.telemetry.newProfilePing.enabled" = false;
    #     "toolkit.telemetry.shutdownPingSender.enabled" = false;
    #     "toolkit.telemetry.updatePing.enabled" = false;
    #     "toolkit.telemetry.bhrPing.enabled" = false;
    #     "toolkit.telemetry.firstShutdownPing.enabled" = false;
    #     "toolkit.telemetry.coverage.opt-out" = true;
    #     "toolkit.coverage.opt-out" = true;
    #     "datareporting.healthreport.uploadEnabled" = false;
    #     "datareporting.policy.dataSubmissionEnabled" = false;
    #     "browser.discovery.enabled" = false;
    #     "browser.tabs.crashReporting.sendReport" = false;
    #     "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
    #     "network.captive-portal-service.enabled" = false;
    #     "network.connectivity-service.enabled" = false;
    #     "browser.ping-centre.telemetry" = false;
    #     "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    #     "browser.newtabpage.activity-stream.telemetry" = false;
    #     "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #     "browser.compactmode.show" = true;
    #     "extensions.getAddons.showPane" = false;
    #     "extensions.htmlaboutaddons.recommendations.enabled" = false;
    #     "browser.shell.checkDefaultBrowser" = false;
    #     "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
    #     "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
    #     "browser.preferences.moreFromMozilla" = false;
    #     "browser.tabs.tabmanager.enabled" = false;
    #     "browser.aboutConfig.showWarning" = false;
    #     "browser.aboutwelcome.enabled" = false;
    #     "browser.display.focus_ring_on_anything" = true;
    #     "browser.privateWindowSeparation.enabled" = false;
    #     "browser.translations.enable" = false;
    #     "browser.urlbar.shortcuts.bookmarks" = false;
    #     "browser.urlbar.shortcuts.history" = false;
    #     "browser.urlbar.shortcuts.tabs" = false;
    #     "browser.translations.alwaysTranslateLanguages" = false;
    #     "browser.translations.neverTranslateLanguages" = true;
    #     "browser.translations.autoTranslate" = false;
    #     "browser.urlbar.suggest.history" = false;
    #     "browser.urlbar.suggest.engines" = false;
    #     "browser.urlbar.suggest.topsites" = false;
    #     "browser.urlbar.suggest.calculator" = true;
    #     "browser.urlbar.unitConversion.enabled" = true;
    #     "browser.newtabpage.activity-stream.feeds.topsites" = false;
    #     "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
    #     "extensions.pocket.enabled" = false;
    #     "browser.download.useDownloadDir" = false;
    #     "browser.download.always_ask_before_handling_new_types" = true;
    #     "browser.download.alwaysOpenPanel" = false;
    #     "browser.download.manager.addToRecentDocs" = false;
    #     "browser.download.open_pdf_attachments_inline" = true;
    #     "browser.bookmarks.openInTabClosesMenu" = false;
    #     "browser.menu.showViewImageInfo" = true;
    #     "findbar.highlightAll" = true;
    #     "general.smoothScroll" = true;
    #     "general.smoothScroll.msdPhysics.enabled" = true;
    #     "media.videocontrols.picture-in-picture.enabled" = false;
    #     "apz.overscroll.enabled" = true;
    #     "app.shield.optoutstudies.enabled" = false;
    #     "app.normandy.enabled" = false;
    #     "app.update.suppressPrompts" = true;
    #     "media.ffmpeg.vaapi.enabled" = true;
    #     "gfx.webrender.all" = true;
    #   };
    # };
  # };
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
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  system.stateVersion = "23.11";
  system.copySystemConfiguration = true;
  # {{ SYSTEM }}
}
