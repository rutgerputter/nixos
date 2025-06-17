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
      volumes = [ "/etc/janitorr.yml:/workspace/application.yml" ];
      podman.user = "rputter";
    };
  };

  environment.etc."janitorr.yml".source = "./application.yaml";
}