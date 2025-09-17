{ pkgs, ... }:
{
  services.xserver.displayManager.lightdm = {
    enable = true;
    greeters = {
      enso = {
        enable = true;
      };
    };
  };
}