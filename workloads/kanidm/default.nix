{ pkgs, ... }:
{
  imports = [
    ./mounts.nix
    ./acme.nix
  ];

  services.kanidm = {
    enableServer = true;
    package = pkgs.kanidm_1_6;
    serverSettings = {
      domain = "realiz-it.nl";
      origin = "https://auth.realiz-it.nl";
      tls_key = "/var/lib/acme/auth.realiz-it.nl/key.pem";
      tls_chain = "/var/lib/acme/auth.realiz-it.nl/full.pem";
      role = "WriteReplica";
      ldapbindaddress = "[::]:636";
      bindaddress = "[::]:443";
    };
  };

  environment.systemPackages = with pkgs; [
    kanidm-provision
    kanidm
  ];

  networking.firewall.allowedTCPPorts = [ 636 443 ];

  /* ensure openldap is launched after certificates are created */
  systemd.services.kanidm = {
    wants = [ "acme-auth.realiz-it.nl.service" ];
    after = [ "acme-auth.realiz-it.nl.service" ];
  };

  /* make acme certificates accessible by kanidm */
  security.acme.defaults.group = "certs";
  users.groups.certs.members = [ "kanidm" ];
}
