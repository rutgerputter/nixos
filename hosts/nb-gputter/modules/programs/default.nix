{ ... }:

{
  imports = [
    ../../../../modules/common/programs
    ../../../../modules/common-desktop/programs/steam-gaming.nix
    ../../../../modules/common-desktop/programs/firefox.nix
  ];

  programs = {

    # Zsh configuration
	  zsh = {
      shellAliases = {
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#nb-gputter";
      };
    };
  };
}
