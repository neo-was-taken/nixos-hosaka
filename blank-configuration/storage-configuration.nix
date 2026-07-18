{ config, modulesPath, pkgs, ... }:

{
  boot = {
    initrd = {
      availableKernelModules = [ "ahci" "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
      systemd.enable = true;
      luks.devices = let
        luks_root_uuid = "881898be-007b-45d1-96cd-206e5e360beb";
      in {
        # LUKS container with root partition
        "luks-${luks_root_uuid}" = {
          device = "/dev/disk/by-uuid/${luks_root_uuid}";
          allowDiscards = true;
        };
      };
    };
    kernelModules = [ "kvm-amd" "8821ce" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "usbcore.autosuspend=-1" "amdgpu.reset=1"];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };
  };

  swapDevices = [{
      device = "/swapfile";
      size = 64 * 1024;
    }];
}
