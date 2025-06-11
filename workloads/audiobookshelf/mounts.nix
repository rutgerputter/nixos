{ ... }:
{
  fileSystems."/var/lib/audiobookshelf" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/audiobookshelf";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/audiobooks" = {
    device = "10.0.99.10:/mnt/hdd_pool/audiobooks";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/podcasts" = {
    device = "10.0.99.10:/mnt/hdd_pool/podcasts";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
