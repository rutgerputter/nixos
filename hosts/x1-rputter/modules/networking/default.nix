{ lib, config, ... }:

{
  age.secrets.wg_x1-rputter_privkey.file = ../../../../secrets/wg_x1-rputter_privkey.age;

  networking = {
    hostName = "x1-rputter";
    # domain = null;
    # extraHosts = "";

    enableIPv6 = true;
    resolvconf = {
      enable = true;
      dnsExtensionMechanism = true;
      dnsSingleRequest = false;
      useLocalResolver = false;
    };

    useDHCP = lib.mkDefault true;

    networkmanager = {
      enable = true;
      dhcp = "internal";
      dns = "default";
      wifi = {
        backend = "wpa_supplicant";
        macAddress = "preserve";
        powersave = false;
        scanRandMacAddress = true;
      };
      ensureProfiles = {
        profiles = { };
      };
    };

    wireless = {
      enable = false;
    };

    firewall = {
      enable = true;
      # Open ports in the firewall, as needed.
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };

    wg-quick.interfaces = {
      "Home" = {
        address = [ "10.51.82.5/32" ];
        dns = [ "10.51.82.1" ];
        privateKeyFile = config.age.secrets.wg_x1-rputter_privkey.path;

        peers = [
          {
            publicKey = "TW3Z6PZ5l4IaJsabP1VpR2vrSnBFKTh3O8CXgeZ00To=";
            allowedIPs = [ "0.0.0.0/0" "::/0" ];
            endpoint = "vpn.prutser.net:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
  systemd.services = {
    wg-quick-Home = {
      wantedBy = lib.mkForce [ ];
    };
  };
}
