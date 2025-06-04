{ pkgs, ... }:
{
  programs = {
	  hyprland = {
      enable = true;
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
  	  xwayland.enable = true;
      withUWSM = true;
    };
    programs.hyprlock.enable = true;
    waybar.enable = true;
    hyprlock.enable = true;
  };

  services.hypridle.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    pyprland
    hyprpicker
    hyprcursor
    hyprpaper
    wofi
  ];

  # Hint Electron apps to use Wayland:
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Extra Portal Configuration
  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = [
      pkgs.kdePackages.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
    ];
  };
}