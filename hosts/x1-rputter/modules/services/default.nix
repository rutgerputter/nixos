{ ... }:

{
  imports = [
    ../../../../modules/common-desktop/services/kanidm.nix
    ../../../../modules/common-desktop/services/lact.nix
  ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.gdm.enable = false;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.autoLogin = {
    enable = false;
  };
  # Disable the X11 windowing system.
  services.xserver.enable = false;

  services.desktopManager.plasma6.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh.enable = true;

  services.lsfg-vk = {
    enable = true;
    ui.enable = true; # installs gui for configuring lsfg-vk
  };

  # Undervolt CPU
  services.throttled = {
    enable = true;
    extraConfig = "
      [GENERAL]
      # Enable or disable the script execution
      Enabled: True
      # SYSFS path for checking if the system is running on AC power
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      # Auto reload config on changes
      Autoreload: True

      ## Settings to apply while connected to Battery power
      [BATTERY]
      # Update the registers every this many seconds
      Update_Rate_s: 30
      # Max package power for time window #1
      PL1_Tdp_W: 35
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 45
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 85
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False

      ## Settings to apply while connected to AC power
      [AC]
      # Update the registers every this many seconds
      Update_Rate_s: 5
      # Max package power for time window #1
      PL1_Tdp_W: 45
      # Time window #1 duration
      PL1_Duration_s: 28
      # Max package power for time window #2
      PL2_Tdp_W: 45
      # Time window #2 duration
      PL2_Duration_S: 0.002
      # Max allowed temperature before throttling
      Trip_Temp_C: 95
      # Set HWP energy performance hints to 'performance' on high load (EXPERIMENTAL)
      # Uncomment only if you really want to use it
      # HWP_Mode: False
      # Set cTDP to normal=0, down=1 or up=2 (EXPERIMENTAL)
      cTDP: 0
      # Disable BDPROCHOT (EXPERIMENTAL)
      Disable_BDPROCHOT: False

      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
      [UNDERVOLT.BATTERY]
      # CPU core voltage offset (mV)
      CORE: -60
      # Integrated GPU voltage offset (mV)
      GPU: -60
      # CPU cache voltage offset (mV)
      CACHE: -60
      # System Agent voltage offset (mV)
      UNCORE: -60
      # Analog I/O voltage offset (mV)
      ANALOGIO: -60

      # All voltage values are expressed in mV and *MUST* be negative (i.e. undervolt)!
      [UNDERVOLT.AC]
      # CPU core voltage offset (mV)
      CORE: -60
      # Integrated GPU voltage offset (mV)
      GPU: -60
      # CPU cache voltage offset (mV)
      CACHE: -60
      # System Agent voltage offset (mV)
      UNCORE: -60
      # Analog I/O voltage offset (mV)
      ANALOGIO: -60

      # [ICCMAX.AC]
      # # CPU core max current (A)
      # CORE:
      # # Integrated GPU max current (A)
      # GPU:
      # # CPU cache max current (A)
      # CACHE:

      # [ICCMAX.BATTERY]
      # # CPU core max current (A)
      # CORE:
      # # Integrated GPU max current (A)
      # GPU:
      # # CPU cache max current (A)
      # CACHE:";
  };
}
