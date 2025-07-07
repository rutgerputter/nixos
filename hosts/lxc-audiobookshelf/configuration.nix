# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ ... }:
{

  networking.hostName = "lxc-audiobookshelf";

  imports = [
    ../../modules/common-lxc
    ../../workloads/audiobookshelf
  ];
}
