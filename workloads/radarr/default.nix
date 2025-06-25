{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    radarr = {
      image = "lscr.io/linuxserver/radarr:latest";
      autoStart = true;
      ports = [ "7878:7878" ];
      volumes = [
          "/data/radarr-config:/config"
          "/data/video:/data/video"
          "/data/downloads:/data/downloads"
          "/data/radarr-custom-services.d:/custom-services.d"
          "/data/radarr-custom-cont-init.d:/custom-cont-init.d"
         ];
      environment = {
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
    };
  };
}