{ ... }:
{
  fileSystems."/data/jellystat-backup-data" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/jellyfin/jellystat/backup-data";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/jellystat-db" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/jellyfin/jellystat/db";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
