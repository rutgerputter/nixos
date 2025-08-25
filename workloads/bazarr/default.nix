{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
    ./subgen.nix
  ];

  services.bazarr = {
    enable = true;
    listenPort = 6767;
    openFirewall = true;
  };
  environment.systemPackages = with pkgs; [
    bazarr
  ];
}