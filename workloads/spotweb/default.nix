{ ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  virtualisation.oci-containers.containers = {
    spotweb = {
      image = "jgeusebroek/spotweb";
      autoStart = true;
      ports = [
        "80:80"
      ];
      volumes = [
        "/data/spotweb-config:/config"
      ];
      environment = {
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
        SPOTWEB_DB_HOST = "spotweb-mariadb";
        SPOTWEB_DB_TYPE = "pdo_mysql";
        SPOTWEB_DB_PORT = "3306";
        SPOTWEB_DB_NAME = "spotweb";
        SPOTWEB_DB_USER = "spotweb";
        SPOTWEB_DB_PASS = "spotweb";
        SPOTWEB_CRON_RETRIEVE = "*/30 * * * *";
      };
      dependsOn = [
        "spotweb-mariadb"
      ];
    };
    spotweb-mariadb = {
      image = "lscr.io/linuxserver/mariadb";
      autoStart = true;
      volumes = [
        "/data/mariadb-spotweb:/config"
      ];
      environment = {
        PUID = "99";
        PGID = "100";
        UMASK = "022";
        TZ = "Europe/Amsterdam";
        MYSQL_ROOT_PASSWORD = "spotweb";
        MYSQL_DATABASE = "spotweb";
        MYSQL_USER = "spotweb";
        MYSQL_PASSWORD = "spotweb";
      };
      labels = {
        "io.containers.autoupdate" = "registry";
      };
    };
  };
}