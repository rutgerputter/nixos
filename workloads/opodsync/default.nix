{ ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    opodsync = {
      image = "docker.io/ganeshlab/opodsync:latest";
      autoStart = true;
      ports = [
        "8080:8080"
      ];
      volumes = [
        "/data/opodsync:/var/www/server/data"
      ];
      labels = {
        "io.containers.autoupdate" = "registry";
      };      
    };
  };
}