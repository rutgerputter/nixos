{ pkgs, ... }:
{
  imports = [ ];

  users = {
    mutableUsers = true;
    users = {
      rputter = {
        description = "Rutger Putter";
        home = "/home/rputter";
        group = "users";
        createHome = true;
        homeMode = "700";
        isSystemUser = false;
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel"];
#         packages = with pkgs; [
#         ];
      };
    };
  };
}
