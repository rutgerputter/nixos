{ ... }:

{
  imports = [
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    
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
