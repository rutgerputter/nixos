{ ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.displayManager.defaultSession = "gnome";
  services.displayManager.autoLogin = {
    enable = false;
  };
  # Disable the X11 windowing system.
  services.xserver.enable = false;

  services.desktopManager.gnome.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh.enable = false;

  # Tailscale VPN
  services.tailscale.enable = true;

}