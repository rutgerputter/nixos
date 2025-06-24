{ ... }:
{
  fileSystems."/var/lib/sonarr/.config/NzbDrone" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/sonarr";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
