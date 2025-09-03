{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.unstable.wivrn;
    openFirewall = true;
    defaultRuntime = true;
    autoStart = true;
  };
}