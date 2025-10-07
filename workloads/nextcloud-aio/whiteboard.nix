{ ... }:
{
  environment.etc."nextcloud-whiteboard-secret".text = ''
    JWT_SECRET_KEY=test123
  '';

  services.nextcloud-whiteboard-server = {
    enable = true;
    settings.NEXTCLOUD_URL = "https://cloud.realiz-it.nl";
    secrets = [ "/etc/nextcloud-whiteboard-secret" ];
  };

  networking.firewall.allowedTCPPorts = [
    3002
  ];
}
