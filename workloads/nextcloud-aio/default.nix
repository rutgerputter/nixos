{ pkgs, config, ... }:
{
  imports = [
    ./mounts.nix
    ./talk-hpb.nix
  ];

  environment.etc."nextcloud-admin-pass".text = "ChangeMe!";
  services.nextcloud = {
    enable = true;
    enableImagemagick = true;
    appstoreEnable = false;
    configureRedis = true;
    home = "/var/lib/nextcloud";
    datadir = "/data/ncdata";
    package = pkgs.nextcloud31;
    hostName = "cloud.realiz-it.nl";
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
      onlyoffice
      previewgenerator
      spreed
      tasks
      twofactor_webauthn
      user_oidc
      whiteboard;
    };
    extraAppsEnable = true;
    notify_push.enable = true;
    notify_push.nextcloudUrl = "https://cloud.realiz-it.nl";
    config = {
      adminpassFile = "/etc/nextcloud-admin-pass";
      dbtype = "pgsql";
    };
    maxUploadSize = "75G";
    phpOptions = {
      "opcache.interned_strings_buffer" = "32";
      "opcache.revalidate_freq" = "60";
    };
    settings = {
      trusted_domains = [ "cloud.realiz-it.nl" "cloud.prutser.net" "vm-nextcloud.services.prutser.net" ];
      trusted_proxies = [ "127.0.0.1" "10.0.10.102" "10.0.10.113" ];
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
  networking.firewall.allowedTCPPorts = [ 80 3002 8000 ];

  environment.etc."nextcloud-whiteboard-secret".text = ''
    JWT_SECRET_KEY=test123
  '';

  services.nextcloud-whiteboard-server = {
    enable = true;
    settings.NEXTCLOUD_URL = "https://cloud.realiz-it.nl";
    secrets = [ "/etc/nextcloud-whiteboard-secret" ];
  };

  environment.etc."nextcloud-onlyoffice-secret".text = ''
    test123
  '';

  services.onlyoffice = {
    enable = true;
    hostname = "localhost";
    jwtSecretFile = "/etc/nextcloud-onlyoffice-secret";
  };

  systemd.services.nextcloud-custom-config = {
    path = [
      config.services.nextcloud.occ
    ];
    script = ''
      nextcloud-occ config:app:set whiteboard collabBackendUrl --value="https://whiteboard.realiz-it.nl"
      nextcloud-occ config:app:set whiteboard jwt_secret_key --value="test123"
      nextcloud-occ config:system:set maintenance_window_start --type=integer --value=23

    '';
    after = [ "nextcloud-setup.service" ];
    wantedBy = [ "multi-user.target" ];
  };
}
