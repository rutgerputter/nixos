{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../modules/common-workload/environment
    ../../modules/common-workload/nix
    ../../modules/common-workload/programs
    ../../modules/common-workload/security
    ../../modules/common-workload/users
    ../../modules/common/localization
    ../../modules/common/nixpkgs
    ../../modules/common/programs
  ];
  boot.isContainer = true;

  config = {
    proxmoxLXC = {
      manageNetwork = false;
      privileged = true;
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