{ ... }:
{
  fileSystems."/var/lib/calibre-web" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/calibre-web";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/ebooks" = {
    device = "10.0.99.10:/mnt/hdd_pool/ebooks";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
