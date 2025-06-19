{ config, pkgs, ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  age.secrets.sonarr_api.file = ../../secrets/sonarr_api.age;
  age.secrets.radarr_api.file = ../../secrets/radarr_api.age;
  age.secrets.bazarr_api.file = ../../secrets/bazarr_api.age;
  age.secrets.jellyseerr_api.file = ../../secrets/jellyseerr_api.age;
  age.secrets.jellyfin_janitorr_api.file = ../../secrets/jellyfin_janitorr_api.age;

  virtualisation.oci-containers.containers = {
    janitorr = {
      image = "ghcr.io/schaka/janitorr:latest";
      autoStart = true;
      ports = [ "8978:8978" ];
      volumes = [ "/etc/janitorr.yml:/workspace/application.yml"
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

  environment.etc."janitorr.yml".text = ''
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
          5: 15d # 15 days
          10: 30d # 1 month - if a movie's files on your system are older than this, they will be deleted
          15: 60d # 2 months
          20: 90d # 3 months
        season-expiration:
          5: 15d # 15 days
          10: 20d # 20 days - if a season's files on your system are older than this, they will be deleted
          15: 60d # 2 months
          20: 120d # 4 months

      tag-based-deletion:
        enabled: true
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
        max-age: 30d # Maximum age to keep a

    clients:
      sonarr:
        enabled: true
        url: "https://sonarr.intern.prutser.net"
        api-key: $(${pkgs.coreutils}/bin/cat ${config.age.secrets.sonarr_api.path})
        delete-empty-shows: true # Delete empty shows if deleting by season. Otherwise leaves Sonarr entries behind.
        determine-age-by: MOST_RECENT # Optional property, use 'most_recent' or 'oldest' - remove this line if Janitorr should determine by upgrades enabled for your profile
      radarr:
        enabled: true
        url: "https://radarr.intern.prutser.net"
        api-key: $(${pkgs.coreutils}/bin/cat ${config.age.secrets.radarr_api.path})
        only-delete-files: false # NOT RECOMMENDED - When set to true, Janitorr will only delete your media files but keep the entries in Radarr
        determine-age-by: most_recent # Optional property, use 'most_recent' or 'oldest' - remove this line if Janitorr should determine by upgrades enabled for your profile
      bazarr:
        enabled: false # Only used if you want to copy over subtitle files managed by Bazarr
        url: "https://bazarr.prutser.net"
        api-key: $(${pkgs.coreutils}/bin/cat ${config.age.secrets.bazarr_api.path})

      ## You can only choose one out of Jellyfin or Emby.
      ## User login is only needed if deletion is enabled.
      jellyfin:
        enabled: true
        url: "https://jellyfin.prutser.net"
        api-key: $(${pkgs.coreutils}/bin/cat ${config.age.secrets.jellyfin_janitorr_api.path})
        delete: false # Jellyfin setup is required for JellyStat. However, if you don't want Janitorr to send delete requests to the Jellyfin API, disable it here
        leaving-soon-tv: "Shows (Leaving Soon)"
        leaving-soon-movies: "Movies (Leaving Soon)"
        leaving-soon-type: MOVIES_AND_TV

      jellyseerr:
        enabled: true
        url: "https://overseerr.prutser.net"
        api-key: $(${pkgs.coreutils}/bin/cat ${config.age.secrets.jellyseerr_api.path})
        match-server: false # Enable if you have several Radarr/Sonarr instances set up in Jellyseerr. Janitorr will match them by the host+port supplied in their respective config settings.
  '';
}