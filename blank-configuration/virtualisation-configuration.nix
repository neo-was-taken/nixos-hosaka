{ config, lib, modulesPath, pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];
      extraConfig = ''
        firewall_backend = "nftables"
        log_filters = "1:virtiofsd 1:qemu"
        log_outputs = "1:file:/tmp/libvirt-debug.log"
      '';
      qemu = {
        vhostUserPackages = [ pkgs.virtiofsd ];
        runAsRoot = true;
        swtpm.enable = false;
        verbatimConfig = ''
          virtiofsd_path = "/run/current-system/sw/bin/virtiofsd"
          vhost_user_dir = "/run/current-system/sw/share/qemu/vhost-user"
        '';
      };
    };
    spiceUSBRedirection = {
      enable = true;
    };
    docker = {
      enable = true;
      daemon.settings = {
        "insecure-registries" = ["registry.futro"];
      };
    };
    waydroid = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}