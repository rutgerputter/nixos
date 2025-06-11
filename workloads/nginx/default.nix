{ pkgs, ... }:
{
  imports = [
    ./acme.nix
  ];
  networking = {
    firewall = {
      # Open ports in the firewall, as needed.
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPorts = [ 443 ];
    };
  };

  services.nginx = {
      enable = true;
      package = pkgs.nginxQuic;

      # Use recommended settings
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      # Only allow PFS-enabled ciphers with AES256
      sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

      appendHttpConfig = ''
        # Add HSTS header with preloading to HTTPS requests.
        # Adding this header to HTTP requests is discouraged
        map $scheme $hsts_header {
            https   "max-age=31536000; includeSubdomains; preload";
        }
        add_header Strict-Transport-Security $hsts_header;

        # Enable CSP for your services.
        #add_header Content-Security-Policy "script-src 'self'; object-src 'none'; base-uri 'none';" always;

        # Minimize information leaked to other domains
        add_header 'Referrer-Policy' 'origin-when-cross-origin';

        # Prevent injection of code in other mime types (XSS Attacks)
        add_header X-Content-Type-Options nosniff;
      '';

      upstreams."pve" = {
        servers = {
          "pve1.services.prutser.net:8006" = { };
          "pve2.services.prutser.net:8006" = { };
        };
      };
      # Add any further config to match your needs, e.g.:
      virtualHosts = let
        base = locations: {
          inherit locations;
          http2 = false;
          http3 = false;
          forceSSL = true;
        };
        cert = certname: {
          useACMEHost = certname;
        };
        proxy = host: port: base {
          "/".proxyPass = "http://" + host + ":" + toString(port) + "/";
          "/".proxyWebsockets = true; # needed if you need to use WebSocket
        };
        proxy-nextcloud = host: port: base {
          "/".proxyPass = "http://" + host + ":" + toString(port) + "$request_uri";
          "/".proxyWebsockets = true; # needed if you need to use WebSocket
          "/".extraConfig = ''
            client_max_body_size 75G;
          '';
        };
        proxy-s = host: base {
          "/".proxyPass = "https://" + host;
          "/".proxyWebsockets = true; # needed if you need to use WebSocket
          "/".extraConfig = ''
            proxy_ssl_verify       off;
          '';
        };
      in {
        "bazarr.intern.prutser.net"    = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 6767;
        "code.intern.prutser.net"      = cert "intern.prutser.net" // proxy "forge.services.prutser.net" 8443;
        "gotify.intern.prutser.net"    = cert "intern.prutser.net" // proxy "10.0.10.107" 81;
        "lidarr.intern.prutser.net"    = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 8686;
        "openbooks.intern.prutser.net" = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 5228;
        "overseerr.intern.prutser.net" = cert "intern.prutser.net" // proxy "lxc-jellyseerr.services.prutser.net" 5055;
        "prowlarr.intern.prutser.net"  = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 9696;
        "radarr.intern.prutser.net"    = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 7878;
        "readarr.intern.prutser.net"   = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 8787;
        "sabnzbd.intern.prutser.net"   = cert "intern.prutser.net" // proxy "downloaders.services.prutser.net" 8080;
        "deluge.intern.prutser.net"    = cert "intern.prutser.net" // proxy "downloaders.services.prutser.net" 8112;
        "sonarr.intern.prutser.net"    = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 8989;
        "spotweb.intern.prutser.net"   = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 7171;
        "forge.intern.prutser.net"     = cert "intern.prutser.net" // proxy "forge.services.prutser.net" 3000;
        "tubesync.intern.prutser.net"  = cert "intern.prutser.net" // proxy "arr.services.prutser.net" 4848;

        "pve.intern.prutser.net"       = cert "intern.prutser.net" // proxy-s "pve";

        "bitwarden.realiz-it.nl"       = cert "realiz-it.nl" // proxy "vaultwarden.services.prutser.net" 80;
        "cloud.realiz-it.nl"           = cert "realiz-it.nl" // proxy-nextcloud "nextcloud.services.prutser.net" 11000;

        "books.prutser.net"            = cert "prutser.net" // proxy "arr.services.prutser.net" 8083;
        "id.prutser.net"               = cert "prutser.net" // proxy "auth.services.prutser.net" 9000;
        "domo.prutser.net"             = cert "prutser.net" // proxy "homeassistant.services.prutser.net" 8123;
        "kuma.prutser.net"             = cert "prutser.net" // proxy "vaultwarden.services.prutser.net" 3001;
        "overseerr.prutser.net"        = cert "prutser.net" // proxy "lxc-jellyseerr.services.prutser.net" 5055;
        "jellyfin.prutser.net"         = cert "prutser.net" // proxy "lxc-jellyfin.services.prutser.net" 8096;
        "audiobookshelf.prutser.net"   = cert "prutser.net" // proxy "lxc-audiobookshelf.services.prutser.net" 8000;
        "www.prutser.net"              = cert "prutser.net" // proxy "wordpress.services.prutser.net" 8080 // { default = true; };
        "prutser.net"                  = cert "prutser.net" // proxy "wordpress.services.prutser.net" 8080;
        "cloud.prutser.net"            = cert "prutser.net" // proxy-nextcloud "nextcloud.services.prutser.net" 11000;
        "ncdemo.prutser.net"           = cert "prutser.net" // proxy-nextcloud "vm-nextcloud-demo.services.prutser.net" 80;
        "mail.prutser.net"             = cert "prutser.net" // proxy "mailcow.services.prutser.net" 88;
        "autodiscover.prutser.net"     = cert "prutser.net" // proxy "mailcow.services.prutser.net" 88;
        "autoconfig.prutser.net"       = cert "prutser.net" // proxy "mailcow.services.prutser.net" 88;
        "blog.prutser.net"             = cert "prutser.net" // proxy "wordpress.services.prutser.net" 8000;

        "cloud.maas-opleidingen.nl"    = cert "maas-opleidingen.nl" // proxy-nextcloud "10.0.10.101" 11000;
        "mail.maas-opleidingen.nl"     = cert "maas-opleidingen.nl" // proxy "mailcow.services.prutser.net" 88;
        "autodiscover.maas-opleidingen.nl" = cert "maas-opleidingen.nl" // proxy "mailcow.services.prutser.net" 88;
        "autoconfig.maas-opleidingen.nl" = cert "maas-opleidingen.nl" // proxy "mailcow.services.prutser.net" 88;

        "cloud.groeinaardetoekomst.nl" = cert "groeinaardetoekomst.nl" // proxy-nextcloud "nextcloud.services.prutser.net" 11000;
        "mail.groeinaardetoekomst.nl"  = cert "groeinaardetoekomst.nl" // proxy "mailcow.services.prutser.net" 88;
        "autodiscover.groeinaardetoekomst.nl" = cert "groeinaardetoekomst.nl" // proxy "mailcow.services.prutser.net" 88;
        "autoconfig.groeinaardetoekomst.nl" = cert "groeinaardetoekomst.nl" // proxy "mailcow.services.prutser.net" 88;
        "cdn.groeinaardetoekomst.nl"   = cert "groeinaardetoekomst.nl" // proxy "wordpress.services.prutser.net" 8081;
      };
  };
}