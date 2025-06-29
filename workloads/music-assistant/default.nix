{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.music-assistant = {
    enable = true;
    providers = [
      "audiobookshelf"
      "builtin"
      "builtin_player"
      "chromecast"
      "hass"
      "hass_players"
      "jellyfin"
      "musicbrainz"
      "player_group"
      "radiobrowser"
      "tunein"
    ];
  };
  environment.systemPackages = with pkgs; [
    music-assistant
  ];

  networking = {
    firewall = {
      # Open ports in the firewall, as needed.
      allowedTCPPorts = [ 8095 8097 ];
      allowedUDPPorts = [ ];
    };
  };
}