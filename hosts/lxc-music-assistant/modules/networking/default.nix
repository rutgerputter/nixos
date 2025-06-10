{ ... }:

{
  # Static IP comes from cloud-init
  systemd.network.enable = true;
  services.cloud-init.network.enable = true;

  networking = {
    #Provide a default hostname
    hostName = "lxc-music-assistant";
    useDHCP = false;

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
