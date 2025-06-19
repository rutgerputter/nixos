{ config, pkgs, ... }:
let
  jellyseerr-application-config = pkgs.writeText "jellyseerr-application-config" ''
    server:
      port: 8978

    logging:
      level:
        com.github.schaka: INFO # Set to debug or trace to get more info about what Janitorr is doing
      threshold:
        file: NONE # Set to TRACE to enable file logging

    # File system access (same mapping as Sonarr, Radarr and Jellyfin) is required to delete TV shows by season and create "Leaving Soon" collections in Jellyfin
    # Currently, Jellyfin does not support an easy way to add only a few seasons or movies to a collection, we need access to temporary symlinks
    # Additionally, checks to prevent deletion on currently still seeding media currently require file system access as well
    file-system:
      access: true
      validate-seeding: true # validates seeding by checking if the original file exists and skips deletion - turning this off will send a delete to the *arrs even if a torrent may still be active
      leaving-soon-dir: "/data/video/leaving-soon" # The directory that's known to Janitorr - this will contain new folders with symlinks to your media library for "Leaving Soon"
      media-server-leaving-soon-dir: "/data/video/leaving-soon" # This is the directory Jellyfin/Emby will be told it can find the "Leaving Soon" library, in case its mapped differently
      from-scratch: true # Clean up entire "Leaving Soon" directory and rebuild from scratch - this can help with clearing orphaned data - turning this off can save resources (less writes to drive)
      free-space-check-dir: "/data/video" # This is the default directory Janitorr uses to check how much space is left on your drives. By default, it checks the entire root - you may point it at a specific folder

    application:
      dry-run: true
      run-once: false # If you enable this, Janitorr will clean up once and then shut down.
      whole-tv-show: false # activating this will treat as a whole show as recently download/watched from a single episode, rather than that episode's season - shows will be deleted as a whole
      whole-show-seeding-check: false # Turning this off, disables the seeding check entirely if whole-tv-show is enabled. Activating this check will keep a whole TV show if any season is still seeding (requires file access).
      leaving-soon: 14d # 14 days before a movie is deleted, it gets added to a "Leaving Soon" type collection (i.e. movies that are 76 to 89 days old)
      exclusion-tag: "janitorr_keep" # Set this tag to your movies or TV shows in the *arrs to exclude media from being cleaned up

      media-deletion:
        enabled: true
        movie-expiration:
          # Percentage of free disk space to expiration time - if the highest given number is not reached, nothing will be deleted
          # If filesystem access is not given, disk percentage can't be determined. As a result, Janitorr will always choose the largest expiration time.
          20: 365d
          30: 400d
        season-expiration:
          20: 365d
          30: 400d

      tag-based-deletion:
        enabled: false
        minimum-free-disk-percent: 100
        schedules:
          - tag: 5 - demo
            expiration: 30d
          - tag: 10 - demo
            expiration: 7d

      episode-deletion: # This ignores Jellystat. Only grab history matters. It also doesn't clean up Jellyfin. There is NO seeding check either.
        enabled: true
        tag: janitorr_daily # Shows tagged with this will have all episodes of their LATEST season deleted by the below thresholds
        max-episodes: 10 # maximum (latest) episodes of this season to keep

    clients:
      sonarr:
        enabled: true
        url: "https://sonarr.intern.prutser.net"
        api-key: @SONARR_API@
        delete-empty-shows: true # Delete empty shows if deleting by season. Otherwise leaves Sonarr entries behind.
        determine-age-by: MOST_RECENT # Optional property, use 'most_recent' or 'oldest' - remove this line if Janitorr should determine by upgrades enabled for your profile
      radarr:
        enabled: true
        url: "https://radarr.intern.prutser.net"
        api-key: @RADARR_API@
        only-delete-files: false # NOT RECOMMENDED - When set to true, Janitorr will only delete your media files but keep the entries in Radarr
        determine-age-by: most_recent # Optional property, use 'most_recent' or 'oldest' - remove this line if Janitorr should determine by upgrades enabled for your profile
      bazarr:
        enabled: true # Only used if you want to copy over subtitle files managed by Bazarr
        url: "https://bazarr.prutser.net"
        api-key: @BAZARR_API@

      ## You can only choose one out of Jellyfin or Emby.
      ## User login is only needed if deletion is enabled.
      jellyfin:
        enabled: true
        url: "https://jellyfin.prutser.net"
        api-key: @JELLYFIN_JANITORR_API@
        delete: false # Jellyfin setup is required for JellyStat. However, if you don't want Janitorr to send delete requests to the Jellyfin API, disable it here
        leaving-soon-tv: "TV Shows (Binnenkort Weg)"
        leaving-soon-movies: "Films (Binnenkort Weg)"
        leaving-soon-type: MOVIES_AND_TV

      jellyseerr:
        enabled: true
        url: "https://overseerr.prutser.net"
        api-key: @JELLYSEERR_API@
        match-server: false # Enable if you have several Radarr/Sonarr instances set up in Jellyseerr. Janitorr will match them by the host+port supplied in their respective config settings.

      jellystat: # Only one, Jellystat or Streamystats can be used
        enabled: true
        whole-tv-show: false # Enabling this will make Jellystat consider TV shows as a whole if any episode of any season has been watched
        url: "https://jellystat.intern.prutser.net"
        api-key: @JELLYSTAT_API@
  '';
in
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  age.secrets.sonarr_api.file = ../../secrets/sonarr_api.age;
  age.secrets.radarr_api.file = ../../secrets/radarr_api.age;
  age.secrets.bazarr_api.file = ../../secrets/bazarr_api.age;
  age.secrets.jellyseerr_api.file = ../../secrets/jellyseerr_api.age;
  age.secrets.jellystat_api.file = ../../secrets/jellystat_api.age;
  age.secrets.jellyfin_janitorr_api.file = ../../secrets/jellyfin_janitorr_api.age;

  virtualisation.oci-containers.containers = {
    janitorr = {
      image = "ghcr.io/schaka/janitorr:latest";
      autoStart = true;
      ports = [ "8978:8978" ];
      volumes = [ "/opt/jellyseerr-application-config.yml:/workspace/application.yml"
                  "/data/tv:/data/tv"
                  "/data/tv:/tv"
                  "/data/tv-archief:/data/tv-archief"
                  "/data/tv-archief:/tv-archief"
                  "/data/movies:/data/movies"
                  "/data/movies:/movies"
                  "/data/video:/data/video"
      ];
      # podman.user = "rputter";
    };
  };

  systemd.services.podman-janitorr = {
    preStart = ''
      mkdir -p /opt
      install --owner root --mode 644 ${jellyseerr-application-config} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @SONARR_API@ ${config.age.secrets.sonarr_api.path} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @RADARR_API@ ${config.age.secrets.radarr_api.path} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @BAZARR_API@ ${config.age.secrets.bazarr_api.path} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @JELLYSEERR_API@ ${config.age.secrets.jellyseerr_api.path} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @JELLYFIN_JANITORR_API@ ${config.age.secrets.jellyfin_janitorr_api.path} /opt/jellyseerr-application-config.yml
      ${pkgs.replace-secret}/bin/replace-secret @JELLYSTAT_API@ ${config.age.secrets.jellystat_api.path} /opt/jellyseerr-application-config.yml
    '';
    path = with pkgs; [ replace-secret ];
  };
}