{ config, ... }:
let
  cfg = config.services.forgejo;
  srv = cfg.settings.server;
in
{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    # Enable support for Git Large File Storage
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "forge.intern.prutser.net";
        # You need to specify this to remove the port from URLs in the web UI.
        ROOT_URL = "https://${srv.DOMAIN}/";
        HTTP_PORT = 3000;
      };
      # You can temporarily allow registration to create an admin user.
      service.DISABLE_REGISTRATION = true;
      # Add support for actions, based on act: https://github.com/nektos/act
      actions = {
        ENABLED = true;
        DEFAULT_ACTIONS_URL = "github";
      };
      # Sending emails is completely optional
      # You can send a test email from the web UI at:
      # Profile Picture > Site Administration > Configuration >  Mailer Configuration
      mailer = {
        ENABLED = true;
        SMTP_ADDR = "mail.maas-opleidingen.nl";
        FROM = "noreply@${srv.DOMAIN}";
        USER = "noreply@${srv.DOMAIN}";
      };
    };
    mailerPasswordFile = config.age.secrets.forgejo-mailer-password.path;
  };

  age.secrets.forgejo-mailer-password = {
    file = ../../secrets/forgejo-mailer-password.age;
    mode = "400";
    owner = "forgejo";
  };
}