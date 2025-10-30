{ config, ... }:

let
  aKC = "kanidm_ssh_authorizedkeys";
in

{
  imports = [
    ./kanidm.nix
  ];

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    authorizedKeysCommand = "/run/wrappers/bin/${aKC} %u";
    authorizedKeysCommandUser = "nobody";
    settings.PubkeyAuthentication = true;
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.UsePAM = true;
  };

  security.wrappers."${aKC}" = {
    source = "${config.services.kanidm.package}/bin/${aKC}";
    owner = "root";
    group = "root";
  };
}
