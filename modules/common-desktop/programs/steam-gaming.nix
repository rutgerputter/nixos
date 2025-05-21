{ ... }:
{
  programs = {
    steam = {
      enable = true;
      localNetworkGameTransfers = {
        openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
  };
}
