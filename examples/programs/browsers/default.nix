{ config, ... }:
let
    cfg = config.modules.core;
in {
    imports = [
        ./firefox.nix
    ];
}
