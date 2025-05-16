{ config, ... }:
let
    cfg = config.modules.core;
in {
    imports = [
        ./forgejo.nix
    ];
}
