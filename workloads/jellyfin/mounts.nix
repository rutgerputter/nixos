{ ... }:
{
  fileSystems."/data/tv" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TV";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };
  fileSystems."/data/movies" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/Movies";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };
  fileSystems."/data/music" = {
    device = "10.0.99.10:/mnt/hdd_pool/music";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };
  fileSystems."/data/audiobooks" = {
    device = "10.0.99.10:/mnt/hdd_pool/audiobooks";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };    
  fileSystems."/data/recordings" = {
    device = "10.0.99.10:/mnt/hdd_pool/recordings";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };   
  fileSystems."/data/vinyl" = {
    device = "10.0.99.10:/mnt/hdd_pool/vinyl";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };   
  fileSystems."/data/putter" = {
    device = "10.0.99.10:/mnt/hdd_pool/putter";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };   
  fileSystems."/data/foto" = {
    device = "10.0.99.10:/mnt/hdd_pool/photo";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };
  fileSystems."/data/tv-archief" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TV-Archief";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };       
  fileSystems."/data/nl-kids" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/NL-Kids";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };       
  fileSystems."/data/nl-kids-tv" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/NL-Kids-TV";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };
  fileSystems."/data/tubesync" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TubeSync";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };    
  fileSystems."/var/lib/jellyfin" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/jellyfin";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" ];
  };            
}
