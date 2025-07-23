{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.calibre-web = {
    enable = true;
    listen.port = "8083";
    options.enableBookUploading = true;
    options.calibreLibrary = "/data/ebooks";
  };
  environment.systemPackages = with pkgs; [
    calibre-web
  ];
}