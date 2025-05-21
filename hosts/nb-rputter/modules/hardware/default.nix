{ config, lib, ... }:

{
  imports = [
    ../../../../hardware/lenovo/T580
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
    graphics = {
        enable = true;
        enable32Bit = true; # Enabled to support some Steam games.
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;    
  
  };
  
  # Thunderbolt 3
  services.hardware.bolt.enable = true;

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
