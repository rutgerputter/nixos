{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    syncthing = {
      image = "lscr.io/linuxserver/syncthing:latest";
      autoStart = true;
      ports = [ "8989:8989" ];
      extraOptions = [ "--network=host" ];
      volumes = [
        "/data/syncthing-config:/config"
        "/data/video/TV:/sync/TV"
        "/data/video/Movies:/sync/Movies"
        "/data/music:/sync/music"
      ];
      environment = {
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
    };
  };
}