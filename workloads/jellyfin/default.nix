{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
    ./vaapi.nix
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];

}