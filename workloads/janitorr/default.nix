{ ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    janitorr = {
      image = "ghcr.io/schaka/janitorr:latest";
      autoStart = true;
      ports = [ ];
      volumes = [ "/etc/janitorr.yml:/workspace/application.yml"
                  "/data/tv:/data/tv"
                  "/data/tv:/tv"
                  "/data/tv-archief:/data/tv-archief"
                  "/data/tv-archief:/tv-archief"
                  "/data/movies:/data/movies"
                  "/data/movies:/movies"
                  "/data/video:/data/video"
      ];
      podman.user = "rputter";
    };
  };

  environment.etc."janitorr.yml".source = "./application.yaml";
}