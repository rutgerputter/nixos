{ pkgs, ... }:
{
  services.kanidm = {
    enableClient = true;
    enablePam = true;
    package = pkgs.kanidm_1_6;
    clientSettings.uri = "https://auth.realiz-it.nl";
    unixSettings = {
      version = "2";
      default_shell = "/bin/zsh";
      home_prefix = "/home/";
      home_attr = "uuid";
      kanidm = {
        pam_allowed_login_groups = ["idm_all_persons"];
        map_group = [
          {
            local = "wheel";
            "with" = "posix_wheel";
          }
        ];
      };
    };
  };
}