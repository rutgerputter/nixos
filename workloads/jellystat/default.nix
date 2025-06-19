{ config, ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  age.secrets.jellystat_db_pass.file = ../../secrets/jellystat_db_pass.age;

  virtualisation.oci-containers.containers = {
    jellystat = {
      image = "cyfershepard/jellystat:latest";
      autoStart = true;
      ports = [ "3000:3000" ];
      volumes = [ "/data/jellystat-backup-data:/app/backend/backup-data" ];
      environmentFiles = [
        "${config.age.secrets.jellystat_db_pass.path}"
      ];
      environment = {
        POSTGRES_USER = "postgres";
        POSTGRES_IP = "jellystat-db";
        POSTGRES_PORT = "5432";
        TZ = "Europe/Amsterdam";
      };
    };
    jellystat-db = {
      image = "postgres:15.2";
      autoStart = true;
      ports = [ "5432:5432" ];
      volumes = [ "/data/jellystat-db:/var/lib/postgresql/data" ];
      environmentFiles = [
        "${config.age.secrets.jellystat_db_pass.path}"
      ];
      environment = {
        POSTGRES_USER = "postgres";
      };
    };
  };
}