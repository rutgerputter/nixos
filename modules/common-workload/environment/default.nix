{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    exfat
    exfatprogs
    gcc
    usbutils
    pciutils
    dmidecode
    git
    htop
    nano
    lshw
    fzf
  ];
}
