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
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://www.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[RESPONSE_TIME] < 300"
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
          ];
        }
      ];
      alerting.gotify = {
        server-url = "https://gotify.intern.prutser.net";
        token = "Af6L_5tY7GRc9Xj";
        default-alert = {
          description = "health check failed";
          send-on-resolved = true;
          failure-threshold = 2;
          success-threshold = 2;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gatus
  ];
}