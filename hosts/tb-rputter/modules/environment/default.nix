{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    gnomeExtensions.system-monitor-next
    gnomeExtensions.ddterm
    gnomeExtensions.hot-edge
    gnomeExtensions.caffeine
    # gnomeExtensions.gsconnect
    gnomeExtensions.pip-on-top
    gnomeExtensions.tailscale-qs
    gnomeExtensions.battery-time
    gnomeExtensions.appindicator
    gnomeExtensions.easyeffects-preset-selector
    iio-sensor-proxy
    gnome-tweaks
  ];
}
