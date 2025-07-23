{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.moodle = {
    enable = true;
    database.type = "pgsql";
    database.createLocally = true;
    poolConfig = {
      pm = "dynamic";
      "pm.max_children" = 32;
      "pm.max_requests" = 500;
      "pm.max_spare_servers" = 4;
      "pm.min_spare_servers" = 2;
      "pm.start_servers" = 2;
    };
  };
  environment.systemPackages = with pkgs; [
    moodle
  ];
}