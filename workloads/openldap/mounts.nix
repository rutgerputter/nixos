{ ... }:
{
  fileSystems."/var/lib/openldap/data" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/openldap";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
