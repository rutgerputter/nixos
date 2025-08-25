{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.gatus = {
    enable = true;
    settings = {
      web.port = 8080;
      endpoints = [{
        name = "prutser.net";
        url = "https://www.prutser.net";
        interval = "1m";
        conditions = [
          "[STATUS] == 200"
          "[RESPONSE_TIME] < 300"
        ];
      }];
    };
  };

  environment.systemPackages = with pkgs; [
    gatus
  ];

  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
  };
}