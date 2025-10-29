{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB1T0HBLR-000L7_S4EMNF0M904617";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                # disable settings.keyFile if you want to use interactive password entry
                passwordFile = "/tmp/secret.key"; # Interactive
                settings = {
                  allowDiscards = true;
                };

                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ]; # Override existing partition
                  # Subvolumes must set a mountpoint in order to be mounted,
                  # unless their parent is mounted
                  subvolumes = {
                    # Subvolume name is different from mountpoint
                    "/rootfs" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/";
                    };
                    # Subvolume name is the same as the mountpoint
                    "/home" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/home";
                    };
                    # Parent is not mounted so the mountpoint must be set
                    "/nix" = {
                      mountOptions = [
                        "compress=zstd"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                    # Subvolume for the swapfile
                    "/swap" = {
                      mountpoint = "/.swapvol";
                      swap = {
                        swapfile.size = "32G";
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
      secondary = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-KBG40ZNV256G_KIOXIA_91EPH7MPQW82";
        content = {
          type = "gpt";
          partitions = {
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is the same as the mountpoint
                  "/games" = {
                    mountOptions = [ "defaults" "compress=zstd" "noatime"];
                    mountpoint = "/mnt/games";
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
