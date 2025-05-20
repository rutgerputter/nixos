{ config, lib, ... }:

{
  imports = [
    ../../../../hardware/pc-rputter
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
  ];

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;
    
    cpu = {
      intel = {
        updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
        sgx.provision.enable = true;
      };
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = false; # Enable pipewire services instead.
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
