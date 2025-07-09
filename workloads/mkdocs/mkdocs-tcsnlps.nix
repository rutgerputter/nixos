{ pkgs, ... }:
{

  systemd.timers."pull-mkdocs" = {
    wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "*:0/1";
        Persistent = true;
        Unit = "pull-mkdocs.service";
      };
  };

  systemd.services."pull-mkdocs" = {
    description = "MKDocs remote pull";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      WorkingDirectory = "/var/lib/mkdocs";
      ExecStart = "${pkgs.git}/bin/git pull";
      Type = "oneshot";
      User = "root";
    };
  };

  programs.git.config = {
    safe.directory = "/var/lib/private/mkdocs";
  };
}