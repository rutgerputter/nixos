{ lib, ... }:

{
  imports = [
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
    ../../../../modules/common-desktop/hardware
  ];

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;
    # NVIDIA
    nvidia.open = true;
    nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services.fprintd.enable = true;

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
