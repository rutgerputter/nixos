{ lib, ... }:

{
  imports = [
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;
  };

  # Enable fwupd
  services.fwupd.enable = lib.mkDefault true;

  # Thunderbolt Service
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
