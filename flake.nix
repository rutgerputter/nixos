{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor?ref=25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nixos-generators,
    nixos-06cb-009a-fingerprint-sensor,
    ...
  }:
  {
    packages.x86_64-linux = {
      proxmox-vm = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./generators/proxmox-vm/configuration.nix
        ];
        format = "proxmox";
      };
      proxmox-lxc = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./generators/proxmox-lxc/configuration.nix
        ];
        format = "proxmox-lxc";
      };
    };
    nixosConfigurations = {
      nb-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-p52
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
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
      tb-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.common-pc-ssd
          # > Our main nixos configuration files and modules <
          ./hosts/tb-rputter/configuration.nix
          ./hosts/tb-rputter/hardware-configuration.nix
          ./hosts/tb-rputter/modules/boot
          ./hosts/tb-rputter/modules/environment
          ./hosts/tb-rputter/modules/hardware
          ./hosts/tb-rputter/modules/home-manager
          ./hosts/tb-rputter/modules/localization
          ./hosts/tb-rputter/modules/networking
          ./hosts/tb-rputter/modules/nix
          ./hosts/tb-rputter/modules/nixpkgs
          ./hosts/tb-rputter/modules/programs
          ./hosts/tb-rputter/modules/services
          ./hosts/tb-rputter/modules/system
          ./hosts/tb-rputter/modules/users
        ];
      };
      pc-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
          nixos-hardware.nixosModules.common-hidpi
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
      vm-nextcloud-demo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          # > Our main nixos configuration files and modules <
          ./hosts/vm-nextcloud-demo/configuration.nix
          ./hosts/vm-nextcloud-demo/modules/boot
          ./hosts/vm-nextcloud-demo/modules/environment
          ./hosts/vm-nextcloud-demo/modules/home-manager
          ./hosts/vm-nextcloud-demo/modules/localization
          ./hosts/vm-nextcloud-demo/modules/networking
          ./hosts/vm-nextcloud-demo/modules/nix
          ./hosts/vm-nextcloud-demo/modules/nixpkgs
          ./hosts/vm-nextcloud-demo/modules/programs
          ./hosts/vm-nextcloud-demo/modules/security
          ./hosts/vm-nextcloud-demo/modules/services
          ./hosts/vm-nextcloud-demo/modules/system
          ./hosts/vm-nextcloud-demo/modules/users
        ];
      };
    };
  };
}
