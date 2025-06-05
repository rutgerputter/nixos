{ lib, ... }:

{
  networking = {
    hostName = "tb-rputter";
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
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
}