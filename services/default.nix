{ config, ... }:
let
    cfg = config.modules.core;
in {
    imports = [
        # ./connectivity
        ./forge
        ./management
        ./media
        ./security
        ./sql
    ];
}
