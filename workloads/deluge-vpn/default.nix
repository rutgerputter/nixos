{ config, ... }:
{
  imports = [
    ../common/podman
    ./mounts.nix
  ];

  age.secrets.deluge_vpn_env.file = ../../secrets/deluge_vpn_env.age ;

  virtualisation.oci-containers.containers = {
    deluge-vpn = {
      image = "binhex/arch-delugevpn:latest";
      autoStart = true;
      privileged = true;
      extraOptions = [
        "--sysctl=net.ipv4.conf.all.src_valid_mark=1"
      ];
      ports = [
        "8112:8112"
        "8118:8118"
        "58846:58846"
        "58946:58946"
      ];
      volumes = [
        "/data/downloads:/data/downloads"
        "/data/deluge-config:/config"
      ];
      environmentFiles = [
        "${config.age.secrets.deluge_vpn_env.path}"
      ];
      environment = {
        VPN_ENABLED = "yes";
        VPN_CLIENT = "wireguard";
        VPN_PROV = "pia";
        VPN_OPTIONS = "";
        STRICT_PORT_FORWARD = "yes";
        ENABLE_PRIVOXY = "yes";
        LAN_NETWORK = "192.168.1.0/24,10.0.10.0/24";
        NAME_SERVER = "209.222.18.222,84.200.69.80,37.235.1.174,1.1.1.1,209.222.18.218,37.235.1.177,84.200.70.40,1.0.0.1";
        DELUGE_DAEMON_LOG_LEVEL = "info";
        DELUGE_WEB_LOG_LEVE = "info";
        ADDITIONAL_PORTS = "1234";
        DEBUG = "false";
        UMASK = "000";
        PUID = "99";
        PGID = "100";
        TZ = "Europe/Amsterdam";
      };
      labels = {
        "io.containers.autoupdate" = "registry";
      };
    };
  };
}