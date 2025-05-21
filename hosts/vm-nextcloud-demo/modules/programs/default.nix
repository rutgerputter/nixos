{ ... }:

{
  imports = [
    ../../../modules/common/programs
  ];

  programs = {
	zsh = {
      shellAliases = {
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#vm-nextcloud-demo";
      };
    };
  };
}
