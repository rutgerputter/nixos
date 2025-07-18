{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.sabnzbd = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    sabnzbd
  ];
}