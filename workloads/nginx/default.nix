{ ... }:
{
  imports = [
    ./acme.nix
  ];

  services.nginx = {
      enable = true;

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

        # Disable embedding as a frame
        add_header X-Frame-Options DENY;

        # Prevent injection of code in other mime types (XSS Attacks)
        add_header X-Content-Type-Options nosniff;

        # This might create errors
        # proxy_cookie_path / "/; secure; HttpOnly; SameSite=strict";
      '';

      # Add any further config to match your needs, e.g.:
      virtualHosts = let
        base = locations: {
          inherit locations;

          forceSSL = true;
          enableACME = true;
        };
        proxy = host: port: base {
          "/".proxyPass = "http://" + host + ":" + toString(port) + "/";
        };
        proxy-s = host: port: base {
          "/".proxyPass = "https://" + host + ":" + toString(port) + "/";
          "/".extraConfig = ''
            proxy_ssl_verify       off;
          '';
        };
      in {
        "bazarr.intern.prutser.net"    = proxy "arr.services.prutser.net" 6767 // { default = true; };
        "code.intern.prutser.net"      = proxy "forge.services.prutser.net" 8443 // { default = true; };
        "gotify.intern.prutser.net"    = proxy "10.0.10.107" 81 // { default = true; };
        "lidarr.intern.prutser.net"    = proxy "arr.services.prutser.net" 8686 // { default = true; };
        "openbooks.intern.prutser.net" = proxy "arr.services.prutser.net" 5228 // { default = true; };
        "overseerr.intern.prutser.net" = proxy "lxc-jellyseerr.services.prutser.net" 5055 // { default = true; };
        "prowlarr.intern.prutser.net"  = proxy "arr.services.prutser.net" 9696 // { default = true; };
        "radarr.intern.prutser.net"    = proxy "arr.services.prutser.net" 7878 // { default = true; };
        "readarr.intern.prutser.net"   = proxy "arr.services.prutser.net" 8787 // { default = true; };
        "sabnzbd.intern.prutser.net"   = proxy "downloaders.services.prutser.net" 8080 // { default = true; };
        "deluge.intern.prutser.net"    = proxy "downloaders.services.prutser.net" 8112 // { default = true; };
        "sonarr.intern.prutser.net"    = proxy "arr.services.prutser.net" 8989 // { default = true; };
        "spotweb.intern.prutser.net"   = proxy "arr.services.prutser.net" 7171 // { default = true; };
        "forge.intern.prutser.net"     = proxy "forge.services.prutser.net" 3000 // { default = true; };
        "tubesync.intern.prutser.net"  = proxy "arr.services.prutser.net" 4848 // { default = true; };
        # TODO PVE LB
        "pve.intern.prutser.net"       = proxy-s "pve1.services.prutser.net" 8006 // { default = true; };

        "bitwarden.realiz-it.nl"       = proxy "vaultwarden.services.prutser.net" 80 // { default = true; };
        "cloud.realiz-it.nl"           = proxy "nextcloud.services.prutser.net" 11000 // { default = true; };

        "books.prutser.net"            = proxy "arr.services.prutser.net" 8083 // { default = true; };
        "id.prutser.net"               = proxy "auth.services.prutser.net" 9000 // { default = true; };
        "domo.prutser.net"             = proxy "homeassistant.services.prutser.net" 8123 // { default = true; };
        "kuma.prutser.net"             = proxy "vaultwarden.services.prutser.net" 3001 // { default = true; };
        "overseerr.prutser.net"        = proxy "lxc-jellyseerr.services.prutser.net" 5055 // { default = true; };
        "jellyfin.prutser.net"         = proxy "jellyfin.services.prutser.net" 8096 // { default = true; };
        "audiobookshelf.prutser.net"   = proxy "jellyfin.services.prutser.net" 13378 // { default = true; };
        "www.prutser.net"              = proxy "wordpress.services.prutser.net" 8080 // { default = true; };
        "prutser.net"                  = proxy "wordpress.services.prutser.net" 8080 // { default = true; };
        "cloud.prutser.net"            = proxy "nextcloud.services.prutser.net" 11000 // { default = true; };
        "ncdemo.prutser.net"           = proxy "vm-nextcloud-demo.services.prutser.net" 80 // { default = true; };
        "mail.prutser.net"             = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autodiscover.prutser.net"     = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autoconfig.prutser.net"       = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "blog.prutser.net"             = proxy "wordpress.services.prutser.net" 8000 // { default = true; };

        "cloud.maas-opleidingen.nl"    = proxy "nextcloud.services.prutser.net" 11000 // { default = true; };
        "mail.maas-opleidingen.nl"     = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autodiscover.maas-opleidingen.nl" = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autoconfig.maas-opleidingen.nl" = proxy "mailcow.services.prutser.net" 88 // { default = true; };

        "cloud.groeinaardetoekomst.nl" = proxy "nextcloud.services.prutser.net" 11000 // { default = true; };
        "mail.groeinaardetoekomst.nl"  = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autodiscover.groeinaardetoekomst.nl" = proxy "mailcow.services.prutser.net" 88 // { default = true; };
        "autoconfig.groeinaardetoekomst.nl" = proxy "mailcow.services.prutser.net" 88 // { default = true; };                
        "cdn.groeinaardetoekomst.nl"   = proxy "wordpress.services.prutser.net" 8081 // { default = true; };
      };
  };
}