{ lib, pkgs, ... }:
{
  users.groups."render" = {
    name = "render";
    gid = lib.mkForce 104;
  };
  users.groups."video" = {
    name = "video";
    gid = lib.mkForce 44;
  };

  users.users.frigate.extraGroups = [ "video" "render" ];
  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    # Only set this if using intel-vaapi-driver
    intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
  };
  systemd.services.frigate.environment.LIBVA_DRIVER_NAME = "iHD"; # Or "i965" if using older driver
  environment.sessionVariables = { LIBVA_DRIVER_NAME = "iHD"; };      # Same here
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      # intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
      libva-vdpau-driver # Previously vaapiVdpau
      # intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      # OpenCL support for intel CPUs before 12th gen
      # see: https://github.com/NixOS/nixpkgs/issues/356535
      intel-compute-runtime-legacy1
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
      intel-ocl # OpenCL support
    ];
  };
}