{ pkgs, config, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      NODE_EXTRA_CA_CERTS = "${config.security.pki.caBundle}";
      HOST = "0.0.0.0";
      PORT = "4000";
    };
  };
  environment.systemPackages = with pkgs; [
    uptime-kuma
  ];

  networking.firewall = {
    allowedTCPPorts = [ 4000 ];
  };
}