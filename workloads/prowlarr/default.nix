{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.prowlarr = {
    enable = true;
    settings.server.port = 9696;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    prowlarr
  ];
}