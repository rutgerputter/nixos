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

  systemd.timers."jellyfin-backup" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 4:45:00";
        Persistent = true;
        Unit = "jellyfin-backup.service";
      };
  };

  systemd.services."jellyfin-backup" = {
    script = ''
      set -eu
      /run/current-system/sw/bin/systemctl stop jellyfin
      ${pkgs.rsync}/bin/rsync -av --delete /var/lib/jellyfin/ /var/lib/jellyfin-backup/
      /run/current-system/sw/bin/systemctl start jellyfin
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  users.users.jellyfin.extraGroups = [ "users" ];
}