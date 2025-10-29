{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.variables = {
    KWIN_FORCE_ASSUME_HDR_SUPPORT=1;
  };
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    intel-gpu-tools
  ];

}
