{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.audiobookshelf = {
    enable = true;
    host = "0.0.0.0";
    port = 8000;
    openFirewall = true;
    dataDir = "audiobookshelf";
  };
  environment.systemPackages = with pkgs; [
    audiobookshelf
  ];
}