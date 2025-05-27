{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../modules/common/localization
    ../../modules/common/nixpkgs
    ../../modules/common/programs
    ../../modules/common-workload/environment
    ../../modules/common-workload/nix
    ../../modules/common-workload/programs
    ../../modules/common-workload/security
    ../../modules/common-workload/users
  ];

  config = {
    proxmoxLXC = {
            # manageNetwork = false;
            # privileged = false;
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