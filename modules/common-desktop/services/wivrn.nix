{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn;
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