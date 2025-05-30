{ modulesPath, lib, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/common-workload/environment
    ../../modules/common-workload/nix
    ../../modules/common-workload/programs
    ../../modules/common-workload/security
    ../../modules/common-workload/users
    ../../modules/common/localization
    ../../modules/common/nixpkgs
    ../../modules/common/programs
  ];

  config = {
    #Provide a default hostname
    networking.hostName = lib.mkDefault "base";
    networking.useDHCP = lib.mkDefault true;

    # Enable QEMU Guest for Proxmox
    services.qemuGuest.enable = lib.mkDefault true;

    # Use the boot drive for grub
    boot.loader.grub.enable = lib.mkDefault true;
    boot.loader.grub.devices = [ "nodev" ];

    boot.growPartition = lib.mkDefault true;

    # Default filesystem
    fileSystems."/" = lib.mkDefault {
      device = "/dev/disk/by-label/nixos";
      autoResize = true;
      fsType = "ext4";
    };

    # The background OpenSSH daemon for remote SSH access to this host.
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = true;
      settings.KbdInteractiveAuthentication = true;
    };

    system.stateVersion = "24.11";
  };
}