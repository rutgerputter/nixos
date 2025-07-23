# NixOS Flake

This flake allows rapid configuration of a local infrastructure. In includes:

- Generators: to generate generic machines like VM's and LXC containers,
which can later be modified to handle workloads
- Hosts: to define (mostly) the workstations that need to apply their config locally
- Modules: all generic system modules that we want to re-use as much as possible
- Secrets: agenix based secrets management
- Workloads: all services we might want to run on VM's or containers

## Quick start

The generators include commands and instructions to make and deploy them

- Colmena is used to deploy workloads to the generic targets.
- Use `nix shell github:zhaofengli/colmena` to get access to the colmena command.
- Use `colmena apply` to update or configure all targets.
- Use `colmena apply --on <target-name>` to specify which target.
Use of wildcards `*` is allowed here.

To apply this flake to a workstation:

- Edit `/etc/nixos/configuration.nix`.
- Add the line `nix.settings.extra-experimental-features = [ "nix-command" "flakes" ];`.
- Execute `sudo nixos-rebuild switch /etc/nixos`.
- Clone the repo to your machine. For instance, `git clone <your repo link here> ~/.nixos`.
- Switch the NixOS instance to the new flake, from that repo path. For instance,`sudo nixos-rebuild switch --flake .#<local hostname>`
- Voila! Your NixOS instance is now configured according to the configuration cloned from the Git repo.
