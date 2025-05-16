{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-snapd.url = "github:nix-community/nix-snapd";
    nix-snapd.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
    fingerprint-sensor.inputs.nixpkgs.follows = "nixpkgs";  
  };

  outputs = {
    self,
    nixpkgs,
    nix-snapd,
    home-manager,
    fingerprint-sensor,
    ...
  }: {
    nixosConfigurations = {
      nb-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nix-snapd.nixosModules.default
          {
            services.snap.enable = true;
          }
          fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
          # > Our main nixos configuration files and modules <
          ./configuration.nix
          ./hardware-configuration.nix
          ./modules/boot
          ./modules/environment
          ./modules/hardware
          ./modules/home-manager
          ./modules/localization
          ./modules/networking
          ./modules/nix
          ./modules/nixpkgs
          ./modules/programs
          ./modules/services
          ./modules/system
          ./modules/users
        ];
      };
    };
  };
}
