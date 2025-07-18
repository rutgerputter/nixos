{ ... }:
{
  fileSystems."/data/deluge-config" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/downloaders/deluge";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/downloads" = {
    device = "10.0.99.10:/mnt/scratch_pool/downloads";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
