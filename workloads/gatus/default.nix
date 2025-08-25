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
      endpoints = [
        {
          name = "prutser.net";
          group = "websites";
          url = "https://www.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[RESPONSE_TIME] < 300"
            "[DOMAIN_EXPIRATION] > 720h"
          ];
        }
        {
          name = "blog.prutser.net";
          group = "websites";
          url = "https://blog.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[RESPONSE_TIME] < 300"
            "[DOMAIN_EXPIRATION] > 720h"
          ];
        }
        {
          name = "jellyfin.prutser.net";
          group = "media stack";
          url = "https://jellyfin.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[RESPONSE_TIME] < 300"
            "[DOMAIN_EXPIRATION] > 720h"
          ];
        }
      ];
      alerting.gotify = {
        server-url = "https://gotify.intern.prutser.net";
        token = "Af6L_5tY7GRc9Xj";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gatus
  ];
}