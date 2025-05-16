# NixOS Flake

This flake allows rapid configuration of a new NixOS machine with the right configurations.

## Quick start

The following steps allow running the flake from a cold install, including the enablement of the nix-command flake feature.

- Edit `/etc/nixos/configuration.nix`.
- Add the line `nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];`.
- Execute `sudo nixos-rebuild switch /etc/nixos`.
- Clone the repo to your machine. For instance, `git clone <your repo link here> ~/.nixos`.
- Switch the NixOS instance to the new flake, from that repo path. For instance, `sudo nixos-rebuild switch --flake ~/.nixos#pc-vm-nixos`. (Replace with any relevant #HOSTNAME at the end.)
- Voila! Your NixOS instance is now configured according to the configuration cloned from the Git repo.
- After any changes are saved to the flake or modules, run `nixos-rebuild switch --flake ~/.nixos#pc-vm-nixos`. You can now ignore /etc/nixos as the flake will update from the folder you run the rebuild command from.
