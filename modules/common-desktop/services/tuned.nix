{ lib, ... }:
{
  services.tuned = {
    enable = true;
    ppdSupport = true;
    settings.dynamic_tuning = true;
  };

  services.tlp.enable = lib.mkForce false;
}
