{ ... }:
{
  fileSystems."/data/tubesync-config" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/tubesync";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/tubesync-db" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/tubesync-db";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/downloads" = {
    device = "10.0.99.10:/mnt/hdd_pool/video/TubeSync";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
