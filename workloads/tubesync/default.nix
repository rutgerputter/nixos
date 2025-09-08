{ config, ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  age.secrets.tubesync_env.file = ../../secrets/tubesync_env.age;

  virtualisation.oci-containers.containers = {
    tubesync = {
      image = "ghcr.io/meeb/tubesync:v0.15.9";
      autoStart = true;
      ports = [ "4848:4848" ];
      volumes = [
          "/data/tubesync-config:/config"
          "/data/downloads:/downloads"
         ];
      networks = [
        "podman"
      ];
      environmentFiles = [
        config.age.secrets.tubesync_env.path
      ];
      environment = {
        TUBESYNC_RENAME_ALL_SOURCES = "true";
        TUBESYNC_POT_IPADDR = "10.0.10.108";
        TUBESYNC_POT_PORT = "4416";
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
      dependsOn = [
        "tubesync-db"
        "tubesync-bgutil-provider"
      ];
    };
    tubesync-bgutil-provider = {
      image = "brainicism/bgutil-ytdlp-pot-provider:1.2.2";
      autoStart = true;
      networks = [
        "podman"
      ];
      ports = [ "4416:4416" ];
      environment = {
        TOKEN_TTL = "6";
      };
    };
    tubesync-db = {
      image = "docker.io/postgres:17";
      autoStart = true;
      ports = [ ];
      volumes = [
        "/data/tubesync-db:/var/lib/postgresql/data"
      ];
      networks = [
        "podman"
      ];
      environmentFiles = [
        config.age.secrets.tubesync_env.path
      ];
      environment = {
        POSTGRES_DB = "tubesync";
        POSTGRES_USER = "postgres";
      };
      labels = {
        "io.containers.autoupdate" = "registry";
      };
    };
  };
}