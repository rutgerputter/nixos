{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.systemPackages = with pkgs; [
    oversteer
    wlx-overlay-s
  ];
}
