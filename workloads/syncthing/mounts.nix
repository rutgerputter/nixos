{ ... }:
{
  fileSystems."/data/syncthing-config" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/syncthing";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/video" = {
    device = "10.0.99.10:/mnt/hdd_pool/video";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/music" = {
    device = "10.0.99.10:/mnt/hdd_pool/music";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
