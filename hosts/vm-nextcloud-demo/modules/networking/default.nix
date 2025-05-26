{ lib, ... }:

{
  networking = {
    #Provide a default hostname
    hostName = lib.mkDefault "base";
    useDHCP = lib.mkDefault true;

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
