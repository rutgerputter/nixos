{ pkgs, ... }:

{
    rputter = {
        name = "rputter";
        description = "Rutger Putter";
        home = "/home/rputter";
        group = "users";
        initialPassword = "Welcome01!";
        createHome = true;
        homeMode = "700";
        isSystemUser = false;
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            hugo
            jellyfin-media-player
            kdePackages.kate
            kdePackages.ktorrent
            kdePackages.kwalletmanager
            kdePackages.kweather
            keepassxc
            proton-pass
            protonmail-desktop
            protonvpn-gui
            signal-desktop
            stremio
            vscodium
        ];
    };
}
