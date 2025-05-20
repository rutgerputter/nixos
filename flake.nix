{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    fingerprint-sensor.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=24.11";
    fingerprint-sensor.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    fingerprint-sensor,
    nixos-generators,
    ...
  }:
  {
    packages.x86_64-linux = {
      vm-nextcloud-demo = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          # you can include your own nixos configuration here, i.e.
          # ./configuration.nix
          ./hosts/vm-nextcloud-demo/configuration.nix
          ./hosts/vm-nextcloud-demo/modules/boot
          ./hosts/vm-nextcloud-demo/modules/environment
          ./hosts/vm-nextcloud-demo/modules/hardware
          ./hosts/vm-nextcloud-demo/modules/home-manager
          ./hosts/vm-nextcloud-demo/modules/localization
          ./hosts/vm-nextcloud-demo/modules/networking
          ./hosts/vm-nextcloud-demo/modules/nix
          ./hosts/vm-nextcloud-demo/modules/nixpkgs
          ./hosts/vm-nextcloud-demo/modules/programs
          ./hosts/vm-nextcloud-demo/modules/services
          ./hosts/vm-nextcloud-demo/modules/system
          ./hosts/vm-nextcloud-demo/modules/users
        ];
        format = "proxmox";

        # optional arguments:
        # explicit nixpkgs and lib:
        # pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
        # additional arguments to pass to modules:
        # specialArgs = { myExtraArg = "foobar"; };

        # you can also define your own custom formats
        # customFormats = { "myFormat" = <myFormatModule>; ... };
        # format = "myFormat";
      };
    };
    nixosConfigurations = {
      nb-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
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
          fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
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
