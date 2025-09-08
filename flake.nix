{
  inputs = {
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    colmena.url = "github:zhaofengli/colmena";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      # IMPORTANT: we're using "libgbm" and is only available in unstable so ensure
      # to have it up-to-date or simply don't specify the nixpkgs input
      inputs.nixpkgs.follows = "nixpkgs";
    };    
  };

  outputs = {
    self,
    disko,
    nixpkgs,
    nixpkgs-xr,
    nixos-hardware,
    nixos-generators,
    nixos-06cb-009a-fingerprint-sensor,
    agenix,
    colmena,
    lsfg-vk-flake,
    ...
  }:
  {
    packages.x86_64-linux = {
      proxmox-vm = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        modules = [
          ./generators/proxmox-vm/configuration.nix
          {
            virtualisation.diskSize = 16 * 1024;
          }
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
          lsfg-vk-flake.nixosModules.default
          disko.nixosModules.disko
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/nb-rputter/configuration.nix
        ];
      };
      nb-gputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          nixos-hardware.nixosModules.lenovo-thinkpad-t460
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-hidpi
          nixos-hardware.nixosModules.common-pc-ssd
          disko.nixosModules.disko
          agenix.nixosModules.default
          {
            environment.systemPackages = [ agenix.packages."x86_64-linux".default ];
          }
          # > Our main nixos configuration files and modules <
          ./hosts/nb-gputter/configuration.nix
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
          lsfg-vk-flake.nixosModules.default
          nixpkgs-xr.nixosModules.nixpkgs-xr
          disko.nixosModules.disko          
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
      lxc-amd-ai = {
        deployment = {
          targetHost = "lxc-amd-ai.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-amd-ai";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/ollama
        ];
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
      lxc-calibre-web = {
        deployment = {
          targetHost = "lxc-calibre-web.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-calibre-web";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/calibre-web
        ];
      };
      lxc-deluge-vpn = {
        deployment = {
          targetHost = "lxc-deluge-vpn.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc" "podman"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-deluge-vpn";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/deluge-vpn
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
      lxc-gatus = {
        deployment = {
          targetHost = "lxc-gatus.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-gatus";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/gatus
        ];
      };
      lxc-gotify = {
        deployment = {
          targetHost = "lxc-gotify.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-gotify";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/gotify
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
          tags = ["lxc" "podman"];
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
          tags = ["lxc" "podman"];
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
          tags = ["lxc" "podman"];
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
      lxc-sabnzbd = {
        deployment = {
          targetHost = "lxc-sabnzbd.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-sabnzbd";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/sabnzbd
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
      lxc-spotweb = {
        deployment = {
          targetHost = "lxc-spotweb.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc" "podman"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-spotweb";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/spotweb
        ];
      };
      lxc-syncthing = {
        deployment = {
          targetHost = "lxc-syncthing.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc" "podman"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-syncthing";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/syncthing
        ];
      };
      lxc-tubesync = {
        deployment = {
          targetHost = "lxc-tubesync.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc" "podman"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-tubesync";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/tubesync
        ];
      };
      lxc-uptime-kuma = {
        deployment = {
          targetHost = "lxc-uptime-kuma.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-uptime-kuma";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/uptime-kuma
        ];
      };
      lxc-vaultwarden = {
        deployment = {
          targetHost = "lxc-vaultwarden.services.prutser.net";
          targetUser = "rputter";
          tags = ["lxc"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "lxc-vaultwarden";
          })
          agenix.nixosModules.default
          ./modules/common-lxc
          ./workloads/vaultwarden
        ];
      };
      vm-auth = {
        deployment = {
          targetHost = "vm-auth.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "vm-auth";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/kanidm
        ];
      };
      vm-forge = {
        deployment = {
          targetHost = "vm-forge.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "vm-forge";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/forgejo
        ];
      };
      vm-forge-runner = {
        deployment = {
          targetHost = "vm-forge-runner.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "vm-forge-runner";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/forgejo/runner.nix
        ];
      };
      vm-moodle = {
        deployment = {
          targetHost = "vm-moodle.services.prutser.net";
          targetUser = "rputter";
          tags = ["vm"];
          sshOptions = [ "-o BatchMode=yes" "-o StrictHostKeyChecking=no" "-o UserKnownHostsFile=/dev/null" ];
        };
        imports = [
          ({...}: {
            networking.hostName = "vm-moodle";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/moodle-aio
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
          ({...}: {
            networking.hostName = "vm-nextcloud-demo";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/nextcloud-aio
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
          ({...}: {
            networking.hostName = "vm-nginx";
          })
          agenix.nixosModules.default
          ./modules/common-vm
          ./workloads/nginx
        ];
      };
    };
  };
}