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
    { device = "/dev/disk/by-uuid/4fcb74c1-e069-436e-8905-f40b53b4f232";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/E4ED-F6AF";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/560c76b5-5e9d-42bb-adb5-127fe2e0af8c"; }
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
