{ lib, ... }:

{
  networking = {
    hostName = "vm-nextcloud-demo";

    useDHCP = lib.mkDefault false;

    # TODO: add static IP

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
