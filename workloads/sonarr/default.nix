{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.sonarr = {
    enable = true;
    openFirewall = true;
    dataDir = "/var/lib/sonarr/.config/NzbDrone";
    settings = {
      update.mechanism = "internal";
      server = {
        urlbase = "sonarr.intern.prutser.net";
        port = 8989;
        bindaddress = "*";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    sonarr
  ];
}