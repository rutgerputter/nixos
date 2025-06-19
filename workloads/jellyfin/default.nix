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
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    intel-gpu-tools
    libva-utils
  ];

  users.users.jellyfin.extraGroups = [ "users" ];

}