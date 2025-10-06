{ ... }:

{
  imports = [
    ../../../../modules/common-desktop/services/kanidm.nix
  ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
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
}