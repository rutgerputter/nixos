{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.systemPackages = with pkgs; [
    kdePackages.qtvirtualkeyboard
    kdePackages.partitionmanager
    kdePackages.filelight
    kdePackages.kcalc
    kdePackages.kscreenlocker
    kdePackages.yakuake
    maliit-keyboard
    ktailctl
    oversteer
  ];
}
