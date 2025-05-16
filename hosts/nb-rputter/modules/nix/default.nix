{
  nix = {
    settings = {
      auto-optimise-store = true;
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