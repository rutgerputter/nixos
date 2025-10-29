{ pkgs, ... }:

{
  imports = [
    ./disko.nix
  ];
  # Bootloader.

  # Add TPM2 packages
  environment.systemPackages = with pkgs; [
    sbctl
    tpm2-tools
    tpm2-tss
  ];
  boot.initrd.systemd.enable = true;

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

  # Plymouth config
  boot.plymouth.enable = true;
  boot.plymouth.theme = "bgrt";
  boot.plymouth.logo = "${pkgs.nixos-icons}/share/icons/hicolor/64x64/apps/nix-snowflake-white.png";

  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.extraModprobeConfig = ''
    options psmouse synaptics_intertouch=0
    options thinkpad_acpi fan_control=1
    options i915 enable_dpcd_backlight=1
  '';

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
