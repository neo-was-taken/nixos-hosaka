{ config, lib, modulesPath, pkgs, ... }:

{
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
    firmware = [ pkgs.linux-firmware ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          UserspaceHID = true;
          ClassicBondedOnly = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  services = {
    printing.enable = true;
    blueman.enable = true;
    hardware.bolt.enable = false;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;
}
