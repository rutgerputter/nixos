{ ... }:
{
  virtualisation.oci-containers.containers.collabora = {
    image = "docker.io/collabora/code:latest";
    ports = [ "9980:9980/tcp" ];
    autoStart = true;
    environment = {
      server_name = "wopi.realiz-it.nl";
      aliasgroup1 = "https://cloud.realiz-it.nl:443";
      dictionaries = "nl_NL,en_US,de_DE,fr_FR";
      extra_params = "--o:ssl.enable=false --o:ssl.termination=true --o:security.seccomp=true";
    };
    labels = {
      "io.containers.autoupdate" = "registry";
    };
  };

  networking.firewall.allowedTCPPorts = [
    9980
    8000
  ];

  services.nginx.virtualHosts."wopi.realiz-it.nl" = {
    listen = [
      {
        addr = "0.0.0.0";
        port = 8000;
        ssl = false;
      }
    ];
    extraConfig = ''
      # static files

      location ^~ /browser {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Host $host;
      }

      # WOPI discovery URL
      location ^~ /hosting/discovery {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Host $host;
      }

      # Capabilities
      location ^~ /hosting/capabilities {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Host $host;
      }

      # main websocket
      location ~ ^/cool/(.*)/ws$ {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_read_timeout 36000s;
      }

      # download, presentation and image upload
      location ~ ^/(c|l)ool {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Host $host;
      }

      # Admin Console websocket
      location ^~ /cool/adminws {
        proxy_pass http://127.0.0.1:9980;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "Upgrade";
        proxy_set_header Host $host;
        proxy_read_timeout 36000s;
      }
    '';
  };
}
