{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    port = 5055;
  };
  environment.systemPackages = with pkgs; [
    jellyseerr
  ];
}