{ config, ... }:
let
    cfg = config.modules.core;
in {
    imports = [
        ./git.nix
        ./ssh-agent.nix
    ];
}
