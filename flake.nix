{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    colmena.url = "github:zhaofengli/colmena";
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
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    nixos-generators,
    nixos-06cb-009a-fingerprint-sensor,
    agenix,
    colmena,
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
    };
    colmenaHive = colmena.lib.makeHive self.outputs.colmena;

    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
        };
        specialArgs = { inherit (self) inputs outputs; };
      };
      lxc-audiobookshelf = {
        deployment = {
          targetHost = "lxc-audiobookshelf.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-audiobookshelf";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/audiobookshelf
        ];
      };
      lxc-bazarr = {
        deployment = {
          targetHost = "lxc-bazarr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-bazarr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/bazarr
        ];
      };
      lxc-forge-runner = {
        deployment = {
          targetHost = "lxc-forge-runner.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-forge-runner";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/forgejo/runner.nix
        ];
      };
      lxc-frigate = {
        deployment = {
          targetHost = "lxc-frigate.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-frigate";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/frigate
        ];
      };
      lxc-janitorr = {
        deployment = {
          targetHost = "lxc-janitorr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-janitorr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/janitorr
        ];
      };
      lxc-jellyfin = {
        deployment = {
          targetHost = "lxc-jellyfin.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-jellyfin";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/jellyfin
        ];
      };
      lxc-jellyseerr = {
        deployment = {
          targetHost = "lxc-jellyseerr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-jellyseerr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/jellyseerr
        ];
      };
      lxc-jellystat = {
        deployment = {
          targetHost = "lxc-jellystat.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-jellystat";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/jellystat
        ];
      };
      lxc-lidarr = {
        deployment = {
          targetHost = "lxc-lidarr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-lidarr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/lidarr
        ];
      };
      lxc-mkdocs-tcsnlps = {
        deployment = {
          targetHost = "lxc-mkdocs-tcsnlps.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-mkdocs-tcsnlps";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/mkdocs
        ];
      };
      lxc-music-assistant = {
        deployment = {
          targetHost = "lxc-music-assistant.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-music-assistant";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/music-assistant
        ];
      };
      lxc-prowlarr = {
        deployment = {
          targetHost = "lxc-prowlarr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-prowlarr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/prowlarr
        ];
      };
      lxc-radarr = {
        deployment = {
          targetHost = "lxc-radarr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-radarr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/radarr
        ];
      };
      lxc-sonarr = {
        deployment = {
          targetHost = "lxc-sonarr.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-sonarr";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/sonarr
        ];
      };
      vm-nextcloud-demo = {
        deployment = {
          targetHost = "vm-nextcloud-demo.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          agenix.nixosModules.default
          ./hosts/vm-nextcloud-demo/configuration.nix
        ];
      };
      vm-nginx = {
        deployment = {
          targetHost = "vm-nginx.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm" "prod"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          agenix.nixosModules.default
          ./hosts/vm-nginx/configuration.nix
        ];
      };
    };
  };
}