{ ... }:
{
  fileSystems."/var/lib/prowlarr" = {
    device = "/mnt/ssd_pool/dockervols/arr/prowlarr";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
