{ lib, pkgs, ... }:

{
  # The services doesn't actually work atm, define an additional service
  # see https://github.com/NixOS/nixpkgs/issues/91352
  systemd.services.wakeonlan = {
    description = "Reenable wake on lan every boot";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp4s0 wol g";
    };
    wantedBy = [ "default.target" ];
  };

  networking = {
    hostName = "pc-rputter";
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
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
      allowedUDPPorts = [ ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}