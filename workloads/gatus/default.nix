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
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "blog.prutser.net";
          group = "websites";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://blog.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "groeinaardetoekomst.nl";
          group = "websites";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://www.groeinaardetoekomst.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "jaspertrouwt.nl";
          group = "websites";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://www.jaspertrouwt.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "rawbirdphotos.nl";
          group = "websites";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://www.rawbirdphotos.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "realiz-infra.nl";
          group = "websites";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://www.realiz-infra.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }

        {
          name = "jellyfin.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://jellyfin.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
          maintenance-windows = [
            {
              start = "01:55";
              duration = "35m";
              timezone = "Europe/Amsterdam";
            }
          ]
        }
        {
          name = "bazarr.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://bazarr.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "deluge.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://deluge.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "lidarr.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://lidarr.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "overseerr.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://overseerr.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "prowlarr.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://prowlarr.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "radarr.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://radarr.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "sabnzbd.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://sabnzbd.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "sonarr.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://sonarr.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "spotweb.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://spotweb.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "tvheadend.intern.prutser.net";
          group = "media stack";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://192.168.1.20:9981";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
          maintenance-windows = [
            {
              start = "01:55";
              duration = "35m";
              timezone = "Europe/Amsterdam";
            }
          ]
        }

        {
          name = "bitwarden.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://bitwarden.realiz-it.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "forge.intern.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://forge.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "pve1.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://pve1.services.prutser.net:8006";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "pve2.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://pve2.services.prutser.net:8006";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "truenas.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://truenas.services.prutser.net/";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "domo.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://domo.prutser.net/";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "dnsmasq";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "192.168.1.1";
          dns = {
            query-name = "fw-rputter.intern.prutser.net";
            query-type = "A";
          };
          interval = "1m";
          conditions = [
            "[BODY] == 192.168.1.1"
            "[DNS_RCODE] == NOERROR"
          ];
        }
        {
          name = "vm-forge-runner.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://vm-forge-runner.services.prutser.net:22";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }
        {
          name = "vm-nginx.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://vm-nginx.services.prutser.net:443";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }
        {
          name = "fw-rputter.intern.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://fw-rputter.intern.prutser.net";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
        }
        {
          name = "lxc-amd-ai.services.prutser.net";
          group = "core";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://lxc-amd-ai.services.prutser.net:11434";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[BODY] == pat(*Ollama is running*)"
          ];
        }

        {
          name = "ap-kantoor.intern.prutser.net";
          group = "access points";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://192.168.1.203";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
        }
        {
          name = "ap-meterkast.intern.prutser.net";
          group = "access points";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://192.168.1.204";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
        }
        {
          name = "ap-slaapkamer.intern.prutser.net";
          group = "access points";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://192.168.1.202";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
        }
        {
          name = "ap-woonkamer.intern.prutser.net";
          group = "access points";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "http://192.168.1.201";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
          ];
        }

        {
          name = "cam-backyard.intern.prutser.net";
          group = "cams";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://192.168.1.216:554";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }
        {
          name = "cam-frontdoor.intern.prutser.net";
          group = "cams";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://192.168.1.215:554";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }

        {
          name = "lms.maas-opleidingen.nl";
          group = "maas-opleidingen";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://lms.maas-opleidingen.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "cloud.maas-opleidingen.nl";
          group = "maas-opleidingen";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://cloud.maas-opleidingen.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "mail.maas-opleidingen.nl";
          group = "maas-opleidingen";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "https://mail.maas-opleidingen.nl";
          interval = "1m";
          conditions = [
            "[STATUS] == 200"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "nc-redis";
          group = "maas-opleidingen";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://nextcloud.services.prutser.net:6379";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }
        {
          name = "nc-turn";
          group = "maas-opleidingen";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tcp://nextcloud.services.prutser.net:3478";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
          ];
        }

        {
          name = "imaps";
          group = "mail";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tls://mail.maas-opleidingen.nl:993";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "smtp";
          group = "mail";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "starttls://mail.maas-opleidingen.nl:25";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
            "[CERTIFICATE_EXPIRATION] > 30d"
          ];
        }
        {
          name = "smtps";
          group = "mail";
          alerts = [
            {
              type = "gotify";
            }
          ];
          url = "tls://mail.maas-opleidingen.nl:465";
          interval = "1m";
          conditions = [
            "[CONNECTED] == true"
            "[CERTIFICATE_EXPIRATION] > 30d"
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
          success-threshold = 1;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gatus
  ];
}