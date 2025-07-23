{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    syncthing = {
      image = "lscr.io/linuxserver/syncthing:latest";
      autoStart = true;
      ports = [
        "8384:8384"
        "22000:22000/tcp"
        "22000:22000/udp"
        "21027:21027/udp"
      ];
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