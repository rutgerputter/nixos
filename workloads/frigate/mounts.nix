{ ... }:
{
  fileSystems."/var/lib/frigate" = {
    device = "10.0.99.10:/mnt/hdd_pool/frigate";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
