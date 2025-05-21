{ ... }:

{
  networking.firewall = {
    # Enable or disable the firewall altogether.
    enable = true;

    # Open ports in the firewall.
    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [ 22 ];
  };
}
