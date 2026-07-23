{ config, lib, pkgs, ... }:

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "pl";
        variant = "";
      };
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    udev.packages = with pkgs; [ gnome-settings-daemon ];
    fprintd.enable = true;
    power-profiles-daemon.enable = true;
    prometheus.exporters.node = {
      enable = true;
      port = 9000;
      enabledCollectors = [
        "cpu"
        "cpufreq"
        "diskstats"
        "ethtool"
        "filesystem"
        "hwmon"
        "loadavg"
        "meminfo"
        "nvme"
        "os"
        "softirqs"
        "systemd"
        "vmstat"
        "wifi"
      ];
      extraFlags = [ "--collector.ntp.protocol-version=4" "--no-collector.mdadm" ];
    };
  };

  gtk.iconCache.enable = false;

  programs = {
    firefox.enable = true;
    chromium.enable = true;
    direnv.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      adwaita-icon-theme
      aisleriot
      alsa-utils
      android-tools
      antigravity-fhs
      appimage-run
      # audacity
      brave
      brlaser
      calibre
      chatbox
      cheese
      chromium
      dbeaver-bin
      dconf-editor
      # deadbeef-with-plugins
      # deluge-gtk
      direnv
      discord
      docker
      dropbox
      easytag
      element-desktop
      firefox-devedition
      floorp-bin
      fooyin
      gcc
      ghostty
      gimp
      git
      gh
      gnome-mahjongg
      gnomeExtensions.appindicator
      gnomeExtensions.burn-my-windows
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-panel
      gnomeExtensions.date-menu-formatter
      gnomeExtensions.night-theme-switcher
      # gnomeExtensions.simpleweather
      hamster
      hicolor-icon-theme
      home-manager
      ibm-plex
      jdk
      # jetbrains.pycharm-community
      keepassxc
      libreoffice
      # librewolf
      lmstudio
      losslesscut-bin
      lutris
      mangohud
      # megasync
      mono
      moonlight-qt
      nh
      nicotine-plus
      nodejs
      obsidian
      opencode
      pandoc
      # parsec-bin
      piper-tts
      plezy
      postman
      proton-vpn
      python3
      remmina
      signal-desktop
      simplex-chat-desktop
      soundconverter
      steam
      telegram-desktop
      terminator
      textpieces
      thunderbird
      veracrypt
      vim
      virtiofsd
      vivaldi
      vlc
      vscodium-fhs
      wget
      waydroid
      waydroid-helper
      winbox4
      wine
      winetricks
      xdg-utils
      # yacreader
    ];
    gnome.excludePackages = (with pkgs; [
      atomix
      cheese
      decibels
      epiphany
      evince
      geary
      gedit
      gnome-calendar
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-photos
      gnome-software
      gnome-terminal
      gnome-tour
      # gnome-weather
      hitori
      iagno
      simple-scan
      showtime
      snapshot
      tali
      totem
      virt-manager
      yelp
    ]);
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
  ];

  systemd.services.prometheus-node-exporter.serviceConfig = {
    RestrictNamespaces = lib.mkForce false;
    ProtectHome = lib.mkForce false;
  };
}
