{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  networking.firewall = {
    allowedTCPPorts = [ 80 ];
  };

  services.moodle = {
    enable = true;
    database.type = "pgsql";
    database.createLocally = true;
    initialPassword = "password";
    extraConfig = ''
      $CFG->wwwroot = 'https://lms-test.prutser.net';
      $CFG->disableupdatenotifications = true;
      $CFG->sslproxy = true;
      $CFG->reverseproxy = true;
    '';
    poolConfig = {
      pm = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.max_spare_servers" = 4;
      "pm.min_spare_servers" = 2;
      "pm.start_servers" = 2;
    };
    virtualHost = {
      hostName = "lms-test.prutser.net";
      adminAddr = "webmaster@prutser.net";
      forceSSL = false;
      enableACME = false;
    };
  };
  environment.systemPackages = with pkgs; [
    moodle
  ];
}