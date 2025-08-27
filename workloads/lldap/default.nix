{ ... }:
{
  imports = [
    ./mounts.nix
  ];

  services.lldap = {
    enable = true;
    settings = {
      ldap_user_email = "rputter@realiz-it.nl";
      ldap_user_dn = "admin";
      ldap_port = 636;
      ldap_host = "::";
      ldap_base_dn = "dc=realiz-it,dc=nl";
      http_url = "auth.realiz-it.nl";
      http_port = 17170;
      http_host = "::";
      database_url = "sqlite://./users.db?mode=rwc";
    };
  };

  networking.firewall.allowedTCPPorts = [ 636 17170 ];
}