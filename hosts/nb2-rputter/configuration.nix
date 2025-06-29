# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/boot
    ./modules/environment
    ./modules/hardware
    ./modules/home-manager
    ./modules/localization
    ./modules/networking
    ./modules/nix
    ./modules/nixpkgs
    ./modules/programs
    ./modules/services
    ./modules/system
    ./modules/users
  ];
}
