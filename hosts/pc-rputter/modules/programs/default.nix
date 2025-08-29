{ ... }:

{
  imports = [
    ../../../../modules/common/programs
    ../../../../modules/common-desktop/programs/steam-gaming.nix
    ../../../../modules/common-desktop/programs/firefox.nix
  ];

  programs = {
    virt-manager.enable = true;
    kdeconnect.enable = true;
    nix-ld.enable = true;

    # Zsh configuration
	zsh = {
      shellAliases = {
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#pc-rputter";
      };
    };
  };
}
