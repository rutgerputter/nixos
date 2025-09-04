{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn.override { cudaSupport = true; };
    openFirewall = true;
    defaultRuntime = true;
    autoStart = false;
  };
}