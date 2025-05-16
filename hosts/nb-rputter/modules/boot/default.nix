{ pkgs, ... }:

{
  # Bootloader.
  
  # Add TPM2 packages
  environment.systemPackages = with pkgs; [
    tpm2-tss
  ];

  # Use the 'systemd-boot EFI' boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  # Hide the OS choice for bootloaders.
  # It's still possible to open the bootloader list by pressing any key
  # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;

  # Ensure boot works with all appropriate storage devices and protocols.
  boot.initrd.luks.devices."luks-ca4832e4-ab65-4015-a638-6291f324e999".device = "/dev/disk/by-uuid/ca4832e4-ab65-4015-a638-6291f324e999";
  boot.initrd.luks.devices."luks-dfbc71e5-c3d0-48c6-8537-29f33435d4f1".device = "/dev/disk/by-uuid/dfbc71e5-c3d0-48c6-8537-29f33435d4f1";
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "kvm-intel" "zfs" ];
  boot.initrd.systemd.enable = true;
  boot.initrd.supportedFilesystems = [ "zfs" ];
  boot.initrd.verbose = false;

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6716ee49-6d4c-46fc-b141-f2a8c222c6ff";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/1985-1E16";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/e1a8e8fc-69c3-4dda-9fd5-9e1084c92a58"; }
    ];

  fileSystems."/home/rputter/GamesSSD" =
    { device = "/dev/disk/by-uuid/b3f7f216-e285-4e8d-8139-cf40004cb344";
      fsType = "ext4";
    };

  # Plymouth config
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";

  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelPackages = pkgs.zfs.latestCompatibleLinuxPackages;
  boot.extraModulePackages = [ ];

  # Enable "Silent Boot"
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportAll = false;
  boot.zfs.forceImportRoot = true;

  # ZFS requires a networking hostId.
  # The 32-bit host ID of the machine, formatted as 8 hexadecimal characters.
  # You should try to make this ID unique among your machines. You can generate a random 32-bit
  # ID using the following commands:
  # `head -c 8 /etc/machine-id`
  # (this derives it from the machine-id that systemd generates) or
  # `head -c4 /dev/urandom | od -A none -t x4`
  # The primary use case is to ensure when using ZFS that a pool isn’t imported accidentally on
  # a wrong machine.
  networking.hostId = "73e4d145";
}