{ pkgs, ... }:
{
  services.kanidm = {
    enableClient = true;
    enablePam = true;
    package = pkgs.kanidm_1_7;
    clientSettings.uri = "https://auth.realiz-it.nl";
    unixSettings = {
      pam_allowed_login_groups = [ "users" ];
      version = "2";
      default_shell = "${pkgs.zsh}/bin/zsh";
      home_prefix = "/home/";
      home_attr = "uuid";
      home_alias = "name";
      uid_attr_map = "name";
      gid_attr_map = "name";
      allow_local_account_override = [ "wheel" "libvirtd" "networkmanager" "users" ];
      kanidm = {
        pam_allowed_login_groups = [ "users" ];
      };
    };
  };
}
