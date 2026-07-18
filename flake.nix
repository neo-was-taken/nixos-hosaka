{
  description = "whatever Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        hosaka = lib.nixosSystem {
          inherit system;
          modules = [ 
            ./configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                users.whatever = import ./home.nix;
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
            nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
            {
              _module.args.inputs = self.inputs;
            }
          ];
        };
      };
  };
}
