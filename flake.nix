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
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.darwin.follows = "";
    };
    comin = {
      url = "github:nlewo/comin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nixos-generators,
    nixos-06cb-009a-fingerprint-sensor,
    agenix,
    comin,
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
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/nb-rputter/configuration.nix
        ];
      };
      nb2-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t460
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.common-pc-ssd
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/nb2-rputter/configuration.nix
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
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/tb-rputter/configuration.nix
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
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/pc-rputter/configuration.nix
        ];
      };
      vm-nextcloud-demo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          # > Our main nixos configuration files and modules <
          ./hosts/vm-nextcloud-demo/configuration.nix
        ];
      };
      vm-nginx = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          # > Our main nixos configuration files and modules <
          ./hosts/vm-nginx/configuration.nix
        ];
      };
      lxc-janitorr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-janitorr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/janitorr
        ];
      };
      lxc-jellyfin = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-jellyfin";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/jellyfin
        ];
      };
      lxc-jellyseerr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-jellyseerr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/jellyseerr
        ];
      };
      lxc-jellystat = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-jellystat";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/jellystat
        ];
      };
      lxc-music-assistant = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-music-assistant";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/music-assistant
        ];
      };
      lxc-audiobookshelf = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-audiobookshelf";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/audiobookshelf
        ];
      };
      lxc-bazarr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-bazarr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/bazarr
        ];
      };
      lxc-lidarr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-lidarr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/lidarr
        ];
      };
      lxc-prowlarr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-prowlarr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/prowlarr
        ];
      };
      lxc-sonarr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-sonarr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/sonarr
        ];
      };
      lxc-radarr = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          agenix.nixosModules.default
          comin.nixosModules.comin
          ({...}: {
            networking.hostName = "lxc-radarr";
            services.comin = {
              enable = true;
              remotes = [{
                name = "origin";
                url = "https://forge.intern.prutser.net/rutgerputter/nixos.git";
                branches.main.name = "prod";
              }];
            };
          })
          ./modules/common-lxc
          ./workloads/radarr
        ];
      };
    };
  };
}
