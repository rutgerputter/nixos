{ lib, ... }:

{
  imports = [
    ../../../../hardware/common/audio/pipewire.nix
    ../../../../hardware/common/audio/upmix.nix
    ../../../../modules/common-desktop/hardware
  ];

  systemd.services = builtins.listToAttrs (map (service: {
      name = service;
      value.environment.SYSTEMD_SLEEP_FREEZE_USER_SESSIONS = "false";
    }) [
      "systemd-suspend"
      "systemd-hibernate"
      "systemd-hybrid-sleep"
      "systemd-suspend-then-hibernate-sleep"
    ]);


  hardware = {
    sensor.iio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    logitech.wireless.enable = true;
    # NVIDIA
    nvidia.open = true;
    nvidia.powerManagement.enable = true;
    nvidia.prime = {
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  };
  };

  hardware.enableAllFirmware = true;
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
