{ pkgs, ... }:
{
  services.wivrn = {
    enable = true;
    package = pkgs.unstable.wivrn.override { cudaSupport = true; };
    openFirewall = true;
    defaultRuntime = true;
    autoStart = true;
  };

  security.wrappers."wivrn-server" = {
    setuid = false;
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+eip";
    source = "${pkgs.unstable.wivrn}/bin/wivrn-server";
  };
}