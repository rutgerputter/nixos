{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn;
    openFirewall = true;
    defaultRuntime = true;
    autoStart = true;
  }
}