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
    enable = false;
    description = "MKDocs remote pull";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.git}/bin/git pull";
      DynamicUser = true;
      AmbientCapabilities = "";
      CapabilityBoundingSet = [ "" ];
      DevicePolicy = "closed";
      LockPersonality = true;
      MemoryDenyWriteExecute = true;
      ProcSubset = "pid";
      ProtectClock = true;
      ProtectControlGroups = true;
      ProtectHome = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      RestrictAddressFamilies = [
        "AF_INET"
        "AF_INET6"
        "AF_NETLINK"
      ];
      RestrictNamespaces = true;
      RestrictRealtime = true;
      SystemCallArchitectures = "native";
      SystemCallFilter = [
        "@system-service"
        "~@privileged @resources"
      ];
      RestrictSUIDSGID = true;
      UMask = "0077";
      WorkingDirectory = "/var/lib/mkdocs";
    };
  };

}