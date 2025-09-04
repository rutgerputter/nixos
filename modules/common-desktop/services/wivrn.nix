{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.unstable.wivrn.override { cudaSupport = true; };
    highPriority = true;
    openFirewall = true;
    defaultRuntime = true;
    autoStart = true;
  };
}