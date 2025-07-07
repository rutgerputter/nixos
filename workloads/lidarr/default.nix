{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    lidarr = {
      image = "lscr.io/linuxserver/lidarr:latest";
      autoStart = true;
      ports = [ "8686:8686" ];
      volumes = [
          "/data/lidarr-config:/config"
          "/data/music:/data/music"
          "/data/downloads:/data/downloads"
          "/data/lidarr-custom-services.d:/custom-services.d"
          "/data/lidarr-custom-cont-init.d:/custom-cont-init.d"
         ];
      environment = {
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
    };
  };
}