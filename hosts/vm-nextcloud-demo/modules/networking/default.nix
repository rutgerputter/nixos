{ ... }:

{
  networking = {
    #Provide a default hostname
    hostName = "vm-nextcloud-demo";
    useDHCP = false;

    # Static IP comes from cloud-init

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
