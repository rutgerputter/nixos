{ pkgs, ... }:
{
  programs = {
    alvr = {
      enable = true;
      package = pkgs.unstable.alvr;
      openFirewall = true;
    };
  };
}
