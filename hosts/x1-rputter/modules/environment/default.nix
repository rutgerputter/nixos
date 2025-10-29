{ pkgs, ... }:
{
  imports = [
    ../../../../modules/common-desktop/environment
  ];
  environment.variables = {
  };
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy
    intel-gpu-tools
  ];

}
