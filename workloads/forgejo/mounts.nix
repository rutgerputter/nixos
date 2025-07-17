{ ... }:
{
  fileSystems."/var/lib/forgejo" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/forgejo/forgejo";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/var/lib/postgresql" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/forgejo/postgresql";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
