{ lib, ... }:

{
  systemd.network.links."10-lan" = {
    matchConfig.PermanentMACAddress = "9C:6B:00:31:6C:78";
    linkConfig.Name = "lan";
  };

  networking = {
    hostName = "pc-rputter";
    # domain = null;
    # extraHosts = "";

    interfaces.lan.wakeOnLan.enable = true;

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
      enableStrongSwan = false;
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
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
      allowedUDPPorts = [ ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}