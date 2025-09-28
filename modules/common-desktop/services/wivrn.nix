{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.wivrn;
    openFirewall = true;
    defaultRuntime = true;
    autoStart = false;
  };

  environment.systemPackages = with pkgs; [
    opencomposite
    wivrn
    xrizer
  ];
}