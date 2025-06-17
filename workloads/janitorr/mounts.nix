{ ... }:
{
  fileSystems."/data/tv" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TV";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/movies" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/Movies";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/tv-archief" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TV-Archief";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/video" = {
    device = "10.0.99.10:/mnt/hdd_pool/video";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
