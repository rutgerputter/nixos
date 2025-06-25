# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ ... }:
{
  imports = [
    ../../workloads/sonarr
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
}
