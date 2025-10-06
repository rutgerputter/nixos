{ pkgs, ... }:
{
  services.kanidm = {
    enableClient = true;
    enablePam = true;
    package = pkgs.unstable.kanidm_1_7;
    clientSettings.uri = "https://auth.realiz-it.nl";
    unixSettings = {
      pam_allowed_login_groups = [ ];
      version = "2";
      default_shell = "${pkgs.zsh}/bin/zsh";
      home_prefix = "/home/";
      home_attr = "uuid";
      home_alias = "name";
      uid_attr_map = "name";
      gid_attr_map = "name";
      allow_local_account_override = [ "wheel" "libvirtd" "networkmanager" "gamemode" "users" ];
      kanidm = {
        pam_allowed_login_groups = [ "users" ];
      };
    };
  };

  # Allow to cache user accounts
  services.accounts-daemon.enable = true;

  /* ensure display-manager is started after kanidm to allow direct logins */
  systemd.services.display-manager = {
    after = [ "kanidm-unixd.service" ];
  };  
}