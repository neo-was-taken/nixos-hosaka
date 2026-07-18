{ config, lib, modulesPath, pkgs, ... }:

{
  networking = {
    hostName = "hosaka";
    useDHCP = lib.mkDefault true;
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 9000 ];
      allowedUDPPorts = [ ];
      trustedInterfaces = [ "virbr0" ];
    };
    nftables.enable = true;
  };
}
