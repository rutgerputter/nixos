{ modulesPath, pkgs, lib, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ../../modules/common/localization
    ../../modules/common/nixpkgs
    ../../modules/common/programs
    ../../modules/common-workload/environment
    ../../modules/common-workload/nix
    ../../modules/common-workload/programs
    ../../modules/common-workload/security
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
  };
  users = {
    mutableUsers = true;
    users = {
      rputter = {
        description = "Rutger Putter";
        home = "/home/rputter";
        group = "users";
        createHome = true;
        homeMode = "700";
        hashedPassword = "$y$j9T$CeaswGxiGtazj7NJYdWAT.$TV/wuX8iTVGeKT9OixL36ALWmnN09EpsDC0LtYh6NBB";
        isSystemUser = false;
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel"];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXgN/t1XjRbHwcsfihSmx+GiRoPBVU0AzL1o8xTZXNJ" ];
      };
    };
  };

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = true;
    settings.KbdInteractiveAuthentication = true;
  };  
}