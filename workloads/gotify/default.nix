{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.gotify = {
    enable = true;
    environment = {
      GOTIFY_DATABASE_DIALECT = "sqlite3";
      GOTIFY_SERVER_PORT = "8080";
    };
  };
  environment.systemPackages = with pkgs; [
    gotify-server
  ];

  networking.firewall = {
    allowedTCPPorts = [ 8080 ];
  };

}