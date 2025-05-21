{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nextcloud31
    nextcloud-notify_push
    nextcloud-whiteboard-server
    # talk?
    # talk-recording?
    collabora-online
    elasticsearch
    imaginary
    clamav
    postgresql
    redis
  ];
}
