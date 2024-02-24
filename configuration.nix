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
    QT_SCALE_FACTOR = "2";
    ELM_SCALE = "2";
    SDL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = "48";
    MOZ_ENABLE_WAYLAND = "1";
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
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "ru" ];
    extensions = {
      "*".installation_mode = "blocked";
      # ublock
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };
      # adblock
      "adblockultimate@adblockultimate.net.xpi" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/adblocker-ultimate/latest.xpi";
        installation_mode = "force_installed";
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
      #   installation_mode = "force_installed";
      # };
    };
    pref = {
      "layout.css.grid-template-masonry-value.enabled" = { Value = true; Status = "locked"; };
      "dom.enable_web_task_scheduling" = { Value = true; Status = "locked"; };
      "layout.css.has-selector.enabled" = { Value = true; Status = "locked"; };
      "dom.security.sanitizer.enabled" = { Value = true; Status = "locked"; };
      "browser.cache.disk.enable" = { Value = false; Status = "locked"; };
      "network.http.pacing.requests.enabled" = { Value = false; Status = "locked"; };
      "network.dns.disablePrefetch" = { Value = true; Status = "locked"; };
      "browser.urlbar.speculativeConnect.enabled" = { Value = false; Status = "locked"; };
      "browser.places.speculativeConnect.enabled" = { Value = false; Status = "locked"; };
      "network.prefetch-next" = { Value = false; Status = "locked"; };
      "network.predictor.enabled" = { Value = false; Status = "locked"; };
      "network.predictor.enable-prefetch" = { Value = false; Status = "locked"; };
      "privacy.partition.bloburl_per_partition_key" = { Value = true; Status = "locked"; };
      "browser.uitour.enabled" = { Value = false; Status = "locked"; };
      "privacy.globalprivacycontrol.enabled" = { Value = true; Status = "locked"; };
      "privacy.globalprivacycontrol.functionality.enabled" = { Value = true; Status = "locked"; };
      "privacy.trackingprotection.enabled" =	{ Value = true; Status = "locked"; };
      "privacy.trackingprotection.pbmode.enabled" = { Value = true; Status = "locked"; };
      "privacy.donottrackheader.enabled" = { Value = true; Status = "locked"; };
      "privacy.resistFingerprinting" = { Value = true; Status = "locked"; };
      "security.remote_settings.crlite_filters.enabled" = { Value = true; Status = "locked"; };
      "security.ssl.treat_unsafe_negotiation_as_broken" = { Value = true; Status = "locked"; };
      "browser.xul.error_pages.expert_bad_cert" = { Value = true; Status = "locked"; };
      "security.tls.enable_0rtt_data" = { Value = false; Status = "locked"; };
      "browser.privatebrowsing.forceMediaMemoryCache" = { Value = true; Status = "locked"; };
      "privacy.history.custom" = { Value = true; Status = "locked"; };
      "browser.search.separatePrivateDefault.ui.enabled" = { Value = true; Status = "locked"; };
      "browser.urlbar.update2.engineAliasRefresh" = { Value = true; Status = "locked"; };
      "browser.search.suggest.enabled" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.quicksuggest.sponsored" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.quicksuggest.nonsponsored" = { Value = false; Status = "locked"; };
      "browser.formfill.enable" = { Value = false; Status = "locked"; };
      "security.insecure_connection_text.enabled" = { Value = true; Status = "locked"; };
      "security.insecure_connection_text.pbmode.enabled" = { Value = true; Status = "locked"; };
      "network.IDN_show_punycode" = { Value = true; Status = "locked"; };
      "services.sync.prefs.sync.layout.spellcheckDefault" = { Value = false; Status = "locked"; };
      "services.sync.prefs.sync.spellchecker.dictionary" = { Value = false; Status = "locked"; };
      "dom.security.https_first" = { Value = true; Status = "locked"; };
      "dom.security.https_only_mode" = { Value = true; Status = "locked"; };
      "signon.rememberSignons" = { Value = false; Status = "locked"; };
      "editor.truncate_user_pastes" = { Value = false; Status = "locked"; };
      "extensions.formautofill.addresses.enabled" = { Value = false; Status = "locked"; };
      "extensions.formautofill.creditCards.enabled" = { Value = false; Status = "locked"; };
      "security.mixed_content.block_display_content" = { Value = true; Status = "locked"; };
      "pdfjs.enableScripting" = { Value = false; Status = "locked"; };
      "extensions.postDownloadThirdPartyPrompt" = { Value = false; Status = "locked"; };
      "privacy.userContext.ui.enabled" = { Value = true; Status = "locked"; };
      "media.peerconnection.ice.proxy_only_if_behind_proxy" = { Value = true; Status = "locked"; };
      "media.peerconnection.ice.default_address_only" = { Value = true; Status = "locked"; };
      "browser.safebrowsing.downloads.remote.enabled" = { Value = false; Status = "locked"; };
      "identity.fxaccounts.enabled" = { Value = false; Status = "locked"; };
      "browser.tabs.firefox-view" = { Value = false; Status = "locked"; };
      "geo.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.unified" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.archive.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.newProfilePing.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.shutdownPingSender.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.updatePing.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.bhrPing.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.firstShutdownPing.enabled" = { Value = false; Status = "locked"; };
      "toolkit.telemetry.coverage.opt-out" = { Value = true; Status = "locked"; };
      "toolkit.coverage.opt-out" = { Value = true; Status = "locked"; };
      "datareporting.healthreport.uploadEnabled" = { Value = false; Status = "locked"; };
      "datareporting.policy.dataSubmissionEnabled" = { Value = false; Status = "locked"; };
      "app.shield.optoutstudies.enabled" = { Value = false; Status = "locked"; };
      "browser.discovery.enabled" = { Value = false; Status = "locked"; };
      "browser.tabs.crashReporting.sendReport" = { Value = false; Status = "locked"; };
      "browser.crashReports.unsubmittedCheck.autoSubmit2" = { Value = false; Status = "locked"; };
      "network.captive-portal-service.enabled" = { Value = false; Status = "locked"; };
      "network.connectivity-service.enabled" = { Value = false; Status = "locked"; };
      "app.normandy.enabled" = { Value = false; Status = "locked"; };
      "browser.ping-centre.telemetry" = { Value = false; Status = "locked"; };
      "browser.newtabpage.activity-stream.feeds.telemetry" = { Value = false; Status = "locked"; };
      "browser.newtabpage.activity-stream.telemetry" = { Value = false; Status = "locked"; };
      "toolkit.legacyUserProfileCustomizations.stylesheets" = { Value = true; Status = "locked"; };
      "app.update.suppressPrompts" = { Value = true; Status = "locked"; };
      "browser.compactmode.show" = { Value = true; Status = "locked"; };
      "extensions.getAddons.showPane" = { Value = false; Status = "locked"; };
      "extensions.htmlaboutaddons.recommendations.enabled" = { Value = false; Status = "locked"; };
      "browser.shell.checkDefaultBrowser" = { Value = false; Status = "locked"; };
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = { Value = false; Status = "locked"; };
      "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = { Value = false; Status = "locked"; };
      "browser.preferences.moreFromMozilla" = { Value = false; Status = "locked"; };
      "browser.tabs.tabmanager.enabled" = { Value = false; Status = "locked"; };
      "browser.aboutConfig.showWarning" = { Value = false; Status = "locked"; };
      "browser.aboutwelcome.enabled" = { Value = false; Status = "locked"; };
      "browser.display.focus_ring_on_anything" = { Value = true; Status = "locked"; };
      "browser.privateWindowSeparation.enabled" = { Value = false; Status = "locked"; };
      "browser.translations.enable" = { Value = true; Status = "locked"; };
      "browser.urlbar.shortcuts.bookmarks" = { Value = false; Status = "locked"; };
      "browser.urlbar.shortcuts.history" = { Value = false; Status = "locked"; };
      "browser.urlbar.shortcuts.tabs" = { Value = false; Status = "locked"; };
      "browser.translations.alwaysTranslateLanguages" = { Value = false; Status = "locked"; };
      "browser.translations.neverTranslateLanguages" = { Value = true; Status = "locked"; };
      "browser.translations.autoTranslate" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.history" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.engines" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.topsites" = { Value = false; Status = "locked"; };
      "browser.urlbar.suggest.calculator" = { Value = true; Status = "locked"; };
      "browser.urlbar.unitConversion.enabled" = { Value = true; Status = "locked"; };
      "browser.newtabpage.activity-stream.feeds.topsites" = { Value = false; Status = "locked"; };
      "browser.newtabpage.activity-stream.feeds.section.topstories" = { Value = false; Status = "locked"; };
      "extensions.pocket.enabled" = { Value = false; Status = "locked"; };
      "browser.download.useDownloadDir" = { Value = false; Status = "locked"; };
      "browser.download.always_ask_before_handling_new_types" = { Value = true; Status = "locked"; };
      "browser.download.alwaysOpenPanel" = { Value = false; Status = "locked"; };
      "browser.download.manager.addToRecentDocs" = { Value = false; Status = "locked"; };
      "browser.download.open_pdf_attachments_inline" = { Value = true; Status = "locked"; };
      "browser.bookmarks.openInTabClosesMenu" = { Value = false; Status = "locked"; };
      "browser.menu.showViewImageInfo" = { Value = true; Status = "locked"; };
      "findbar.highlightAll" = { Value = true; Status = "locked"; };
      "apz.overscroll.enabled" = { Value = true; Status = "locked"; };
      "general.smoothScroll" = { Value = true; Status = "locked"; };
      "general.smoothScroll.msdPhysics.enabled" = { Value = true; Status = "locked"; };
      "media.videocontrols.picture-in-picture.enabled" = { Value = false; Status = "locked"; };
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
