{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nextcloud-notify_push
    nextcloud-whiteboard-server
    # talk?
    # talk-recording?
    collabora-online
    # elasticsearch
    imaginary
    clamav
    postgresql
    redis
  ];

  services = {
    nextcloud = {
      appstoreEnable = true;
      autoUpdateApps.enable = false;
      caching.apcu = true;
      caching.memcached = true;
      caching.redis = true;
      cli.memoryLimit = "1G";
      config = {
        adminuser = "rputter";
        adminpassFile = "/opt/adminpassFile.txt";
        dbtype = "sqlite";
      };
      configureRedis = true;
      database.createLocally = true;
      datadir = "/mnt/nextcloud";
      enable = true;
      enableImagemagick = true;
      home = "/var/lib/nextcloud";
      hostName = "ncdemo.prutser.net";
      https = true;
      maxUploadSize = "20G";
      nginx.recommendedHttpHeaders = true;
      package = pkgs.nextcloud31;
      notify_push.enable = true;
      settings = {
        overwriteprotocol = "https";
        trusted_domains = [ "ncdemo.prutser.net" ];
        trusted_proxies = [ "caddy.services.prutser.net" ];
      };
    };
    nextcloud-whiteboard-server = {
      enable = true;
      secrets = [ ];
      settings = {
        NEXTCLOUD_URL = "https://ncdemo.prutser.net";
      };
    };
  };
}
