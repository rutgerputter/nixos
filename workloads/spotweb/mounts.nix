{ ... }:
{
  fileSystems."/data/spotweb-config" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/spotweb";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/mariadb-spotweb" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/mariadb-spotweb";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
