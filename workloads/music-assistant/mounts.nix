{ ... }:
{
  fileSystems."/var/lib/private/music-assistant" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/jellyfin/music-assistant";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
