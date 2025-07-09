{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (python313.withPackages (
      ps: with ps; [
        mkdocs
        mkdocs-autorefs
        mkdocs-awesome-nav
        mkdocs-get-deps
        mkdocs-linkcheck
        mkdocs-markmap
        mkdocs-material
        mkdocs-material-extensions
      ]
    ))
  ];

  systemd.services."mkdocs" = {
    enable = true;
    description = "MKDocs Web Service";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "/run/current-system/sw/bin/mkdocs serve --dev-addr 0.0.0.0:8000";
      DynamicUser = true;
      StateDirectory = "mkdocs";
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

  networking.firewall = {
    allowedTCPPorts = [ 8000 ];
  };

}