{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    deploy-rs.url = "github:serokell/deploy-rs";
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
    deploy-rs,
    nixos-06cb-009a-fingerprint-sensor,
    agenix,
    ...
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    # nixpkgs with deploy-rs overlay but force the nixpkgs package
    deployPkgs = import nixpkgs {
      inherit system;
      overlays = [
        deploy-rs.overlays.default # or deploy-rs.overlays.default
        (self: super: { deploy-rs = { inherit (pkgs) deploy-rs; lib = super.deploy-rs.lib; }; })
      ];
    };
    specialArgs = { inherit (self) inputs outputs; };
    lxcModules = [
      agenix.nixosModules.default
      ./modules/common-lxc
    ];
  in
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
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-janitorr";
          })
          ./workloads/janitorr
        ];
      };
      lxc-jellyfin = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-jellyfin";
          })
          ./workloads/jellyfin
        ];
      };
      lxc-frigate = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-frigate";
          })
          ./workloads/frigate
        ];
      };
      lxc-jellyseerr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-jellyseerr";
          })
          ./workloads/jellyseerr
        ];
      };
      lxc-jellystat = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-jellystat";
          })
          ./workloads/jellystat
        ];
      };
      lxc-music-assistant = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-music-assistant";
          })
          ./workloads/music-assistant
        ];
      };
      lxc-audiobookshelf = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-audiobookshelf";
          })
          ./workloads/audiobookshelf
        ];
      };
      lxc-bazarr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-bazarr";
          })
          ./workloads/bazarr
        ];
      };
      lxc-lidarr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-lidarr";
          })
          ./workloads/lidarr
        ];
      };
      lxc-prowlarr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-prowlarr";
          })
          ./workloads/prowlarr
        ];
      };
      lxc-sonarr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-sonarr";
          })
          ./workloads/sonarr
        ];
      };
      lxc-radarr = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-radarr";
          })
          ./workloads/radarr
        ];
      };
      lxc-mkdocs-tcsnlps = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-mkdocs-tcsnlps";
          })
          ./workloads/mkdocs
        ];
      };
      lxc-forge-runner = nixpkgs.lib.nixosSystem {
        inherit system;
        inherit specialArgs;
        modules = lxcModules ++ [
          ({...}: {
            networking.hostName = "lxc-forge-runner";
          })
          ./workloads/forgejo/runner.nix
        ];
      };
    };

    deploy = {
      sshUser = "rputter";
      user = "root";
      interactiveSudo = false;
      sshOpts = ["-oStrictHostKeyChecking=accept-new"];

      nodes = {
        vm-nextcloud-demo = {
          hostname = "vm-nextcloud-demo.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.vm-nextcloud-demo;
          };
        };
        vm-nginx = {
          hostname = "vm-nginx.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.vm-nginx;
          };
        };
        lxc-janitorr = {
          hostname = "lxc-janitorr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-janitorr;
          };
        };
        lxc-jellyfin = {
          hostname = "lxc-jellyfin.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-jellyfin;
          };
        };
        lxc-frigate = {
          hostname = "lxc-frigate.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-frigate;
          };
        };
        lxc-jellyseerr = {
          hostname = "lxc-jellyseerr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-jellyseerr;
          };
        };
        lxc-jellystat = {
          hostname = "lxc-jellystat.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-jellystat;
          };
        };
        lxc-music-assistant = {
          hostname = "lxc-music-assistant.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-music-assistant;
          };
        };
        lxc-audiobookshelf = {
          hostname = "lxc-audiobookshelf.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-audiobookshelf;
          };
        };
        lxc-bazarr = {
          hostname = "lxc-bazarr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-bazarr;
          };
        };
        lxc-lidarr = {
          hostname = "lxc-lidarr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-lidarr;
          };
        };
        lxc-prowlarr = {
          hostname = "lxc-prowlarr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-prowlarr;
          };
        };
        lxc-sonarr = {
          hostname = "lxc-sonarr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-sonarr;
          };
        };
        lxc-radarr = {
          hostname = "lxc-radarr.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-radarr;
          };
        };
        lxc-mkdocs-tcsnlps = {
          hostname = "lxc-mkdocs-tcsnlps.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-mkdocs-tcsnlps;
          };
        };
        lxc-forge-runner = {
          hostname = "lxc-forge-runner.services.prutser.net";
          profiles.system = {
            path =
              deployPkgs.deploy-rs.lib.activate.nixos
              self.nixosConfigurations.lxc-forge-runner;
          };
        };
      };
    };
    # This is highly advised, and will prevent many possible mistakes
    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
  };
}
