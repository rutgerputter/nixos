{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.uptime-kuma = {
    enable = true;
    settings = {
      NODE_EXTRA_CA_CERTS = {
        _type = "literalExpression";
        text = "config.security.pki.caBundle";
      };
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