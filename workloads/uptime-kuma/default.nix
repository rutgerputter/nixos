{ pkgs, config, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      NODE_EXTRA_CA_CERTS = "${config.security.pki.caBundle}";
      HOST = "0.0.0.0";
      PORT = "4000";
    };
  };
  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  networking.firewall = {
    allowedTCPPorts = [ 4000 ];
  };

  systemd.timers."kuma-backup" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*-*-* 5:45:00";
        Persistent = true;
        Unit = "kuma-backup.service";
      };
  };

  systemd.services."kuma-backup" = {
    script = ''
      set -eu
      /run/current-system/sw/bin/systemctl stop uptime-kuma
      ${pkgs.rsync}/bin/rsync -av --delete /var/lib/private/uptime-kuma /var/lib/uptime-kuma-backup
      /run/current-system/sw/bin/systemctl start uptime-kuma
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

}