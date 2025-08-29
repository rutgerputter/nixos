{ pkgs, ... }:
{
  services.kanidm = {
    enableClient = true;
    enablePam = true;
    package = pkgs.kanidm_1_6;
    clientSettings.uri = "https://auth.realiz-it.nl";
    unixSettings = {
      pam_allowed_login_groups = [ "posix_users" ];
      version = "2";
      default_shell = "/run/current-system/sw/bin/zsh";
      home_prefix = "/home/";
      home_attr = "uuid";
      home_alias = "name";
      uid_attr_map = "name";
      gid_attr_map = "name";
      kanidm = {
        pam_allowed_login_groups = [ "posix_users" ];
        map_group = [
          {
            local = "wheel";
            "with" = "posix_wheel";
          }
          {
            local = "libvirtd";
            "with" = "posix_libvirtd";
          }
          {
            local = "networkmanager";
            "with" = "posix_networkmanager";
          }
          {
            local = "gamemode";
            "with" = "posix_gamemode";
          }
          {
            local = "users";
            "with" = "posix_users";
          }
        ];
      };
    };
  };
}