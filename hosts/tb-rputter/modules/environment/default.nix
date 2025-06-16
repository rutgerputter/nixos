{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    gnome-tweaks
  ];
}
