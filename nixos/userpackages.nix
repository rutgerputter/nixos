{ pkgs, ... }:
{
  users.users.rputter = {
    packages = with pkgs; [
      signal-desktop
      unstable.bitwarden-desktop
      vscode
      vlc
      haruna
      thunderbird-latest
      heroic
      protonup-qt
      finamp
      jellyfin-media-player
      gimp-with-plugins
      mission-center
      bottles
      isoimagewriter
      kdenlive
      nextcloud-client
      spotube
      boatswain
      teams-for-linux
      moonlight-qt
      prusa-slicer
    ];
  };
}
