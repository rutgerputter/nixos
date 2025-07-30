{ pkgs, ... }:
{
  imports = [ ];

  users = {
    mutableUsers = false;
    users = {
      root = {
        hashedPassword = "!";
      };
      rputter = {
        description = "Rutger Putter";
        home = "/home/rputter";
        group = "users";
        createHome = true;
        homeMode = "700";
        initialPassword = "Welkom123";
        isSystemUser = false;
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "networkmanager" "wheel" "gamemode" "libvirtd" "nixbld" ];
        packages = with pkgs; [
          signal-desktop
          unstable.bitwarden-desktop
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
          kdePackages.kdenlive
          nextcloud-client
          spotube
          boatswain
          teams-for-linux
          moonlight-qt
          prusa-slicer
          obs-studio
          bookworm
        ];
      };
    };
  };
}
