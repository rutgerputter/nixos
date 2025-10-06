{ ... }:
{
  fileSystems."/data/ncdata" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/nextcloud-nix/ncdata";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
    fileSystems."var/lib/postgresql" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/nextcloud-nix/postgres";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
