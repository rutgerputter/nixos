{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.gatus = {
    enable = true;
    openFirewall = true;
    settings = {
      web.port = 8080;
    };
    configFile = "./config.yaml";
  };

  environment.systemPackages = with pkgs; [
    gatus
  ];
}