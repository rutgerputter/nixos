{ ... }:
{
  fileSystems."/data/sonarr-config" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/sonarr";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/sonarr-custom-services.d" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/sonarr-custom-services.d";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/sonarr-custom-cont-init.d" = {
    device = "10.0.99.10:/mnt/ssd_pool/dockervols/arr/sonarr-custom-cont-init.d";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/video" = {
    device = "10.0.99.10:/mnt/hdd_pool/video";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
  fileSystems."/data/downloads" = {
    device = "10.0.99.10:/mnt/scratch_pool/downloads";
    fsType = "nfs";
    options = [ "nfsvers=4.2" "nolock" "soft" "rw" "nconnect=6" ];
  };
}



# "/data/sonarr-config:/config"
# "/data/video:/data/video"
# "/data/downloads:/data/downloads"
# "/data/sonarr-custom-services.d:/custom-services.d"
# "/data/sonarr-custom-cont-init.d:/custom-cont-init.d"