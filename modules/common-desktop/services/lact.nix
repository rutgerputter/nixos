{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ unstable.lact ];
  systemd.packages = with pkgs; [ unstable.lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}