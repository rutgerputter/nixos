{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-diskseq/3";
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
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ]; # Override existing partition
                # Subvolumes must set a mountpoint in order to be mounted,
                # unless their parent is mounted
                subvolumes = {
                  # Subvolume name is different from mountpoint
                  "/rootfs" = {
                    mountpoint = "/";
                  };
                  # Subvolume name is the same as the mountpoint
                  "/home" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/home";
                  };
                  # Sub(sub)volume doesn't need a mountpoint as its parent is mounted
                  "/home/rputter" = { };
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
                      swapfile.size = "8G";
                    };
                  };
                };
              };
            };
          };
        };
      };
      games1 = {
        type = "disk";
        device = "/dev/disk/by-diskseq/1";
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
                  "/games1" = {
                    mountOptions = [ "defaults" "compress=zstd" "noatime"];
                    mountpoint = "/mnt/games1";
                  };
                };
              };
            };
          };
        };
      };
      games2 = {
        type = "disk";
        device = "/dev/disk/by-diskseq/2";
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
                  "/games2" = {
                    mountOptions = [ "defaults" "compress=zstd" "noatime"];
                    mountpoint = "/mnt/games2";
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