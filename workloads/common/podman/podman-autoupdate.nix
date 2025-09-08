{ ... }:

{
  # Needs label io.containers.autoupdate = registry on the containers
  systemd.timers.update-containers = {
    timerConfig = {
      Unit = "update-containers.service";
      OnCalendar = "Sun 02:00";  # Set to run every Sunday at 2 AM
    };
    wantedBy = [ "timers.target" ];
  };

  systemd.services.update-containers = {
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "podman auto-update";  # Command to trigger the auto-update
    };
  };
}