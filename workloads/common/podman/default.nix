{ pkgs, ... }:
{
  # Enable container support
  virtualisation = {
    podman = {
      enable = true; # Needed to populate /run/user/1000/podman/podman.sock
      dockerCompat = true; # Create a `docker` alias for podman, to use it as a drop-in replacement
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
    oci-containers.backend = "podman";
  };

  # add podman and podman-compose
  environment.systemPackages = with pkgs; [ podman-compose podman-tui ];

  networking.firewall.interfaces."podman+" = {
    allowedUDPPorts = [ 53 ];
    allowedTCPPorts = [ 53 ];
  };

  # Allow non-root containers to access lower port numbers
  boot.kernel.sysctl."net.ipv4.ip_unprivileged_port_start" = 80;
}