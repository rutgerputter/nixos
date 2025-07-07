{ ... }:
{
  fileSystems."/var/lib/private/prowlarr" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/prowlarr";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
