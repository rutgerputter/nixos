{ pkgs, ... }:
{
  imports = [ ];

  users = {
    mutableUsers = true;
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
      };
    };
  };
}
