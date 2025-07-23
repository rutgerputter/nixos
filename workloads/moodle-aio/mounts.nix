{ ... }:
{
  fileSystems."/var/lib/moodle" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/lms";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}
