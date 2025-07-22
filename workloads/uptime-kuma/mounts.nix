{ ... }:
{
  fileSystems."/var/lib/private/uptime-kuma" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/uptimekuma";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
