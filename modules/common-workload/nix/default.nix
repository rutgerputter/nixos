{
  nix = {
    settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [ "https://colmena.cachix.org" ];
      trusted-substituters = [ "https://cache.nixos.org" "https://colmena.cachix.org" ];
      trusted-public-keys = [ "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg=" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "-d";
    };
  };
}
