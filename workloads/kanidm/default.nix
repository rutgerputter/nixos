{ ... }:
{
  imports = [
    ./mounts.nix
    ./acme.nix
  ];

  services.kanidm = {
    enableServer = true;
    serverSettings = {
      db_path = "/var/lib/kanidm/kanidm.db";
      domain = "realiz-it.nl";
      tls_key = "/var/lib/acme/auth.realiz-it.nl/key.pem";
      tls_chain = "/var/lib/acme/auth.realiz-it.nl/full.pem";
      role = "WriteReplica";
      ldapbindaddress = "[::]:636";
      bindaddress = "[::]:8443";
    };
  };

  networking.firewall.allowedTCPPorts = [ 636 8443 ];

  /* ensure openldap is launched after certificates are created */
  systemd.services.kanidm = {
    wants = [ "acme-auth.realiz-it.nl.service" ];
    after = [ "acme-auth.realiz-it.nl.service" ];
  };
}
