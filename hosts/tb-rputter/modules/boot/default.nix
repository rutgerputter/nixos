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
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "usbhid" "uas" "sd_mod" ];
  boot.initrd.kernelModules = [ "kvm-intel" ];
  boot.initrd.systemd.enable = true;
  boot.initrd.supportedFilesystems = [ ];
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

  # Plymouth config
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/48x48/apps/nix-snowflake-white.png";

  boot.kernelModules = [ "kvm-intel" ];
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
}
