{ pkgs, ... }:
{
  imports = [
    ./kanidm.nix
  ];

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    authorizedKeysCommand = "${pkgs.kanidm_1_7}/bin/kanidm_ssh_authorizedkeys %u";
    authorizedKeysCommandUser = "nobody";
    settings.PubkeyAuthentication = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.UsePAM = true;
  };
}
