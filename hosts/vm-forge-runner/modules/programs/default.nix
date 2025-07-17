{ ... }:

{
  imports = [
    ../../../../modules/common/programs
    ../../../../modules/common-workload/programs
  ];

  programs = {
	  zsh = {
      shellAliases = {
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#vm-forge-runner";
      };
    };
  };
}
