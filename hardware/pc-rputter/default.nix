{ lib, ... }:

{
  imports = [
    ../common/cpu/intel/raptor-lake
    ../common/gpu/nvidia
    ../common/ssd
  ];

  # Essential Firmware
  hardware.enableRedistributableFirmware = lib.mkDefault true;

}
