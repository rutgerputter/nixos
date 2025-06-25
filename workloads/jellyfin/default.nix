{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
    ./vaapi.nix
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    intel-gpu-tools
    libva-utils
  ];

  # Enable cron service
  services.cron = {
    enable = true;
    systemCronJobs = [
      "45 4 * * *      root    systemctl restart jellyfin.service"
    ];
  };

  users.users.jellyfin.extraGroups = [ "users" ];

}