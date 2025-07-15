{ config, ... }:
{
  imports = [
    ./modules/boot
    ./modules/environment
    ./modules/home-manager
    ./modules/localization
    ./modules/networking
    ./modules/nix
    ./modules/nixpkgs
    ./modules/programs
    ./modules/security
    ./modules/services
    ./modules/system
    ./modules/users
  ];

  lollypops.deployment = {
    # Where on the remote the configuration (system flake) is placed
    config-dir = "/var/src/lollypops";

    deploy-method = "copy";

    # SSH connection parameters
    ssh.host = "${config.networking.hostName}";
    ssh.user = "root";
    ssh.command = "ssh";
    ssh.opts = [];

    # sudo options
    sudo.enable = true;
    sudo.command = "sudo";
    sudo.opts = [];
  };
}
