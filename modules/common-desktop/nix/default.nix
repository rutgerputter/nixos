{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [ "https://cache.nixos.org" "https://colmena.cachix.org"];
      trusted-substituters = [ "https://cache.nixos.org" "https://colmena.cachix.org"];
    };
    optimise = {
      automatic = true;
      dates = [ "12:00" ]; # Optional; allows customizing optimisation schedule
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
