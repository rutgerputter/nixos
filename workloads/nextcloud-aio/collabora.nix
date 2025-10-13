{ ... }:
{
  services.collabora-online = {
    enable = true;
    port = 8000; # default
    settings = {
      # Rely on reverse proxy for SSL
      ssl = {
        enable = false;
        termination = true;
      };

      net = {
        listen = "any";
      };

      # Restrict loading documents from WOPI Host nextcloud.example.com
      storage.wopi = {
        "@allow" = true;
        host = ["cloud.realiz-it.nl"];
      };

      # Set FQDN of server
      server_name = "wopi.realiz-it.nl";
    };
  };

  networking.firewall.allowedTCPPorts = [
    9980
    8000
  ];
#   services.nginx = {
#     enable = true;
#     # I recommend these, but it's up to you
#     recommendedProxySettings = true;
#     recommendedTlsSettings = true;
#
#     virtualHosts."wopi.realiz-it.nl" =  {
#       listen = [
#         {
#           addr = "0.0.0.0";
#           port = 8000;
#           ssl = false;
#         }
#       ];
#       enableACME = false;
#       forceSSL = false;
#       locations."/" = {
#         proxyPass = "http://[::1]:${toString config.services.collabora-online.port}";
#         proxyWebsockets = true; # collabora uses websockets
#       };
#     };
#   };
}
