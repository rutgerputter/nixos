{ lib, ... }:

{
  imports = [
    ../../../common/cpu/intel/kaby-lake
    ../../../common/gpu/nvidia-optimus
    ../../../common/pc/laptop
    ../../../common/ssd
  ];

  # Essential Firmware
  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # Enable fwupd
  services.fwupd.enable = lib.mkDefault true;

  # Fingerprint stuff, requires flake config
  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                                            
    backend = "python-validity";                                              
  }; 

}
