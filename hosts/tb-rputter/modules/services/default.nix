{ pkgs, ... }:
let
  monitorsXmlContent = builtins.readFile /home/REPALCE_WITH_USERNAME/.config/monitors.xml;
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in
{
  # Enable the GNOME Desktop Environment.
  services.displayManager.defaultSession = "gnome";
  services.displayManager.autoLogin = {
    enable = false;
  };
  services.xserver.displayManager.gdm.enable = true;

  services.xserver.desktopManager.gnome.enable = true;

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}"
  ];

  # Disable the X11 windowing system.
  services.xserver.enable = false;

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