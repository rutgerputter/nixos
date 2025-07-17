{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    sonarr = {
      image = "lscr.io/linuxserver/sonarr:latest";
      autoStart = true;
      ports = [ "8989:8989" ];
      volumes = [
          "/data/sonarr-config:/config"
          "/data/video:/data/video"
          "/data/downloads:/data/downloads"
          "/data/sonarr-custom-services.d:/custom-services.d"
          "/data/sonarr-custom-cont-init.d:/custom-cont-init.d"
         ];
      environment = {
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
    };
  };
}