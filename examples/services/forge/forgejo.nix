{ lib, pkgs, config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.forgejo = {
    enable = true;
    user = "forgejo";
    group = "forgejo";
    stateDir = "/var/lib/forgejo";
    database = {
      type = "postgres";
      user = "forgejo";
      port = 5432;
      name = "forgejo";
      host = "127.0.0.1";
    };
    # Enable support for Git Large File Storage
    lfs.enable = true;
    useWizard = true;
    repositoryRoot = "${cfg.stateDir}/repositories";
    settings = {
      server = {
        DOMAIN = "forge.bearman.nl";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "http://${srv.DOMAIN}:3000/"; 
        HTTP_PORT = 3000;
        PROTOCOL = "http";
        DISABLE_SSH = true;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true; 
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      admin = {
        USER = "test";
        PASSWORD = "test";
        EMAIL = "mike+forge@bearman.nl";
      };
    };
  };

  # Give mike group access to forgejo config
  users.users.mike.extraGroups = [ "forgejo" ];
}
