{ pkgs, config, ... }:
{
  imports = [
    ../common/podman
  ];

  environment.etc."nextcloud-admin-pass".text = "ChangeMe!";
  services.nextcloud = {
    enable = true;
    enableImagemagick = true;
    appstoreEnable = false;
    configureRedis = true;
    datadir = "/mnt/nextcloud";
    package = pkgs.nextcloud31;
    hostName = "ncdemo.prutser.net";
    database.createLocally = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
      calendar
      collectives
      contacts
      cookbook
      deck
      files_mindmap
      files_retention
      forms
      groupfolders
      impersonate
      integration_openai
      mail
      maps
      news
      notes
      notify_push
      previewgenerator
      recognize
      richdocuments
      sociallogin
      spreed
      tasks
      twofactor_webauthn
      whiteboard;
    };
    extraAppsEnable = true;
    notify_push.enable = true;
    notify_push.nextcloudUrl = "http://vm-nextcloud-demo.services.prutser.net";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "pgsql";
    };
    maxUploadSize = "1G";
    phpOptions = {
      "opcache.interned_strings_buffer" = "32";
      "opcache.revalidate_freq" = "60";
    };
    settings = {
      trusted_domains = [ "ncdemo.prutser.net" "vm-nextcloud-demo.services.prutser.net" ];
      trusted_proxies = [ "10.0.10.102" "10.0.10.113" ];
      log_type = "file";
      default_phone_region = "NL";
      overwriteprotocol = "https";
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };
  };
  services.nextcloud-whiteboard-server.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 ];

  virtualisation.oci-containers.containers = {
    nextcloud-aio-talk = {
      image = "ghcr.io/nextcloud-releases/aio-talk:latest";
      autoStart = true;
      ports = [
        "8081:8081"
        "3478:3478/tcp"
        "3478:3478/udp"
      ];
      environment = {
        NC_DOMAIN = "ncdemo.prutser.net";
        TALK_HOST = "nextcloud-aio-talk";
        TURN_SECRET = "test-secret";
        SIGNALING_SECRET = "test-secret";
        TZ = "Europe/Amsterdam";
        TALK_PORT = "3478";
        INTERNAL_SECRET = "test-secret";
      };
      capabilities = {
        NET_RAW = true;
      };
    };
  };
}
