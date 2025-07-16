{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://cache.nixos.org" "https://colmena.cachix.org"];
      trusted-substituters = [ "https://cache.nixos.org" "https://colmena.cachix.org"];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
  };
}
