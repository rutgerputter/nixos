{ ... }:
{
  imports = [
    ../common/podman
  ];

  virtualisation.oci-containers.containers = {
    janitorr = {
      image = "ghcr.io/schaka/janitorr:latest";
      autoStart = true;
      ports = [ ];
      volumes = [ ];
      podman.user = "rputter";
    };
  };

}