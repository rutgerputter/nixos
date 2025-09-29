{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn.override { cudaSupport = true; };
    openFirewall = true;
    defaultRuntime = true;
    autoStart = false;
    highPriority = true;
  };

  environment.systemPackages = with pkgs; [
    opencomposite
    wivrn
    xrizer
  ];
}