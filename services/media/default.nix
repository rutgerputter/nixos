{ config, ... }:
let
    cfg = config.modules.core;
in {
    imports = [
        ./jellyfin.nix
    ];
}
