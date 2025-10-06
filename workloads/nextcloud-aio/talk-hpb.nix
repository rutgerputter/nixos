{ ... }:
{
  imports = [
    ../common/podman
  ];

  networking.firewall.allowedTCPPorts = [ 8081 3478 ];
  networking.firewall.allowedUDPPorts = [ 3478 ];

  virtualisation.oci-containers.containers = {
    nextcloud-talk-hpb = {
      image = "ghcr.io/nextcloud-releases/aio-talk:latest";
      autoStart = true;
      ports = [ 
        "3478:3478/tcp"
        "3478:3478/udp"
        "8081:8081"
      ];
      environment = {
        NC_DOMAIN = "cloud.realiz-it.nl";
        TALK_HOST = "signaling.realiz-it.nl";
        TALK_PORT = "3478";
        TURN_SECRET = "1111";
        SIGNALING_SECRET = "2222";
        INTERNAL_SECRET = "3333";
      };
      labels = {
        "io.containers.autoupdate" = "registry";
      };
    };
  };
}