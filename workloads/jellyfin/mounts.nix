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
  fileSystems."/data/music" = {
    device = "10.0.99.10:/mnt/hdd_pool/music";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/audiobooks" = {
    device = "10.0.99.10:/mnt/hdd_pool/audiobooks";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/recordings" = {
    device = "10.0.99.10:/mnt/hdd_pool/recordings";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/vinyl" = {
    device = "10.0.99.10:/mnt/hdd_pool/vinyl";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/putter" = {
    device = "10.0.99.10:/mnt/hdd_pool/putter";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/foto" = {
    device = "10.0.99.10:/mnt/hdd_pool/photo";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/tv-archief" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TV-Archief";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/nl-kids" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/NL-Kids";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/nl-kids-tv" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/NL-Kids-TV";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/tubesync" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TubeSync";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/var/lib/jellyfin" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/jellyfin/jellyfin";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/video" = {
    device = "10.0.99.10:/mnt/hdd_pool/video";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
