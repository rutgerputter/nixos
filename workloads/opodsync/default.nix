{ ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    spotweb = {
      image = "docker.io/jganeshlab/opodsync";
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