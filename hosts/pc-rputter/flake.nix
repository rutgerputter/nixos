{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }:
  {
    nixosConfigurations = {
      pc-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
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
