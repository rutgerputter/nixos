{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.radarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/radarr/.config/Radarr";
    settings = {
      update.mechanism = "internal";
      server = {
        urlbase = "radarr.intern.prutser.net";
        port = 7878;
        bindaddress = "*";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    radarr
  ];
}