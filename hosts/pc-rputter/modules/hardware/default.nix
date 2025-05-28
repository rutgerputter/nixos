{ lib, config, ... }:
let
  nvidiaPackage = config.hardware.nvidia.package;
in
{
  imports = [
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    # enable the open source drivers if the package supports it
    nvidia.open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;    
  
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
  };
}
