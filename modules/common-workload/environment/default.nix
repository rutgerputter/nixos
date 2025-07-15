{ pkgs, ... }:
{
  environment.variables = {
    NIX_REMOTE = "daemon";
  };
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
    lsd
  ];
}
