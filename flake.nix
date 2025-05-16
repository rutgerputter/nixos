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
    fingerprint-sensor,
    ...
  }:
  {
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
          ./hosts/nb-rputter/configuration.nix
          ./hosts/nb-rputter/hardware-configuration.nix
          ./hosts/nb-rputter/modules/boot
          ./hosts/nb-rputter/modules/environment
          ./hosts/nb-rputter/modules/hardware
          ./hosts/nb-rputter/modules/home-manager
          ./hosts/nb-rputter/modules/localization
          ./hosts/nb-rputter/modules/networking
          ./hosts/nb-rputter/modules/nix
          ./hosts/nb-rputter/modules/nixpkgs
          ./hosts/nb-rputter/modules/programs
          ./hosts/nb-rputter/modules/services
          ./hosts/nb-rputter/modules/system
          ./hosts/nb-rputter/modules/users
        ];
      };
      pc-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          # > Our main nixos configuration files and modules <
          ./hosts/pc-rputter/configuration.nix
          ./hosts/pc-rputter/hardware-configuration.nix
          ./hosts/pc-rputter/modules/boot
          ./hosts/pc-rputter/modules/environment
          ./hosts/pc-rputter/modules/hardware
          ./hosts/pc-rputter/modules/home-manager
          ./hosts/pc-rputter/modules/localization
          ./hosts/pc-rputter/modules/networking
          ./hosts/pc-rputter/modules/nix
          ./hosts/pc-rputter/modules/nixpkgs
          ./hosts/pc-rputter/modules/programs
          ./hosts/pc-rputter/modules/services
          ./hosts/pc-rputter/modules/system
          ./hosts/pc-rputter/modules/users
        ];
      };      
    };
  };
}