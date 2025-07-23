{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      ROCKET_ADDRESS = "0.0.0.0";
      ROCKET_PORT = 8000;
      DOMAIN = "https://bitwarden.realiz-it.nl";
      SENDS_ALLOWED = true;
      INCOMPLETE_2FA_TIME_LIMIT = 3;
      DISABLE_ICON_DOWNLOAD = false;
      SIGNUPS_ALLOWED = false;
      INVITATIONS_ALLOWED = true;
      EMERGENCY_ACCESS_ALLOWED = true;
      PASSWORD_ITERATIONS = 100000;
      SHOW_PASSWORD_HINT = false;
      INVITATION_ORG_NAME = "Vaultwarden";
      IP_HEADER = "X-Real-IP";
      ICON_REDIRECT_CODE = 302;
      ICON_CACHE_TTL = 2592000;
      ICON_CACHE_NEGTTL = 259200;
      ICON_DOWNLOAD_TIMEOUT = 10;
      HTTP_REQUEST_BLOCK_NON_GLOBAL_IPS = true;
      DISABLE_2FA_REMEMBER = false;
      AUTHENTICATOR_DISABLE_TIME_DRIFT = false;
      REQUIRE_DEVICE_EMAIL = false;
      RELOAD_TEMPLATES = false;
      LOG_TIMESTAMP_FORMAT = "%Y-%m-%d %H:%M:%S.%3f";
      DISABLE_ADMIN_TOKEN = false;
      SMTP_HOST = "mailcow.services.prutser.net";
      SMTP_SECURITY = "starttls";
      SMTP_PORT = 25;
      SMTP_FROM = "rutger@prutser.net";
      SMTP_FROM_NAME = "Bitwarden_PutterNet";
      SMTP_TIMEOUT = 15;
      SMTP_ACCEPT_INVALID_CERTS = false;
      SMTP_ACCEPT_INVALID_HOSTNAMES = false;
      EMAIL_TOKEN_SIZE = 6;
      EMAIL_EXPIRATION_TIME = 600;
      EMAIL_ATTEMPTS_LIMIT = 3;
    };
  };
  environment.systemPackages = with pkgs; [
    vaultwarden
  ];

  networking.firewall = {
    allowedTCPPorts = [ 8000 ];
  };

}