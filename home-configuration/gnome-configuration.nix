{ config, lib, pkgs, ... }:

{
  dconf.settings = {
    "org/gnome/desktop/peripherals/pointingstick" = {
      accel-profile = "flat";
    };
    "org/gnome/desktop/interface" = {
      gtk-enable-primary-paste = "true";
    };
    "org/gnome/nautilus/preferences" = {
      date-time-format = "detailed";
      default-folder-view = "list-view";
      show-create-link = true;
      show-delete-permanently = true;
    };
    "org/gnome/nautilus/icon-view" = {
      captions = [ "size" "type" "none" ];
    };
    "org/gnome/desktop/background" = {
      picture-options = "none";
      primary-color = "#000000";
    };
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "close:appmenu";
      # action-right-click-titlebar = "minimize";
      # action-middle-click-titlebar = "lower";
    };
     "org/gnome/mutter" = {
       edge-tiling = true;
       experimental-features = [ "scale-monitor-framebuffer" ];
     };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/" ];
      screensaver = [ "<Control><Super>q" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "/run/current-system/sw/bin/nautilus --new-window";
      name = "Nautilus";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>w";
      command = "ghostty";
      name = "Ghostty";
    };
    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Alt><Super>j" ];
      toggle-tiled-right = [ "<Alt><Super>l" ];
    };
    "org/gnome/desktop/wm/keybindings" = {
      toggle-maximized = [ "<Alt><Super>k" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        burn-my-windows.extensionUuid
        caffeine.extensionUuid
        dash-to-panel.extensionUuid
        date-menu-formatter.extensionUuid
        night-theme-switcher.extensionUuid
        # simpleweather.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/date-menu-formatter" = {
      pattern = "dd\nMM\nyy\nE\nHH\nmm\nss";
      text-align = "right";
      update-level = "2";
    };
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = "2";
      restore-state = true;
      show-indicator = "always";
      show-notifications = false;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enable = true;
      natural-scroll = false;
    };
    "org/gnome/desktop/sound" = {
      allow-volume-above-100-percent = true;
    };
  };  
}