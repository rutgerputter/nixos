{ ... }:

{
  programs.steam = {
    enable = true;
    # dedicatedServer = {
    #   openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # };
    localNetworkGameTransfers = {
      openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    remotePlay = {
      openFirewall = true; # Open ports in the firewall for Steam Remote Play
    };
  };
}
