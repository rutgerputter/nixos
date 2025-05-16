{ ... }:

{
  services.jellyfin = {
    enable = true;
    group = "jellyfin";
    user = "jellyfin";
    openFirewall = true;
    # logDir = "\${cfg.dataDir}/log";
    # cacheDir = "/var/cache/jellyfin";
    # dataDir = "/var/lib/jellyfin";
    # configDir = "\${cfg.dataDir}/config";
  };

  services.jellyseerr.enable = false;
}