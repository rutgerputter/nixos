{ pkgs, ... }:

{
  imports = [
    ../../../../modules/common/programs
    ../../../../modules/common-desktop/programs/firefox.nix
  ];

  programs = {
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
    # Zsh configuration
	  zsh = {
      shellAliases = {
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#tb-rputter";
      };
    };
  };
}
