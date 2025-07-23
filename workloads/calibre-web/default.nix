{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.calibre-web = {
    enable = true;
    listen.ip = "0.0.0.0";
    listen.port = 8083;
    options.enableBookUploading = true;
    options.calibreLibrary = "/data/ebooks";
  };
  environment.systemPackages = with pkgs; [
    calibre-web
  ];
  networking.firewall = {
    allowedTCPPorts = [ 8083 ];
  };
}