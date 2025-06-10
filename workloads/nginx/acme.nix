{ ... }:
{
  imports = [
  ];

  users.users.nginx.extraGroups = [ "acme" ];

  security.acme = {
    acceptTerms = true;
    maxConcurrentRenewals = 10;
    defaults.email = "rutger@prutser.net";
    # defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
    defaults.dnsProvider = "cloudflare"; # Cloudflare DNS API
    defaults.dnsPropagationCheck = true;
    defaults.dnsResolver = "1.1.1.1:53";
    defaults.environmentFile = "/opt/cloudflare.key";
    defaults.reloadServices = [ "nginx" ];
    certs."intern.prutser.net" = {
      domain = "*.intern.prutser.net";
      extraDomainNames = [ "intern.prutser.net" ];
    };
    certs."prutser.net" = {
      domain = "*.prutser.net";
      extraDomainNames = [ "prutser.net" ];
    };
    certs."realiz-it.nl" = {
      domain = "*.realiz-it.nl";
      extraDomainNames = [ "realiz-it.nl" ];
    };
    certs."maas-opleidingen.nl" = {
      domain = "*.maas-opleidingen.nl";
      extraDomainNames = [ "maas-opleidingen.nl" ];
    };
    certs."groeinaardetoekomst.nl" = {
      domain = "*.groeinaardetoekomst.nl";
      extraDomainNames = [ "groeinaardetoekomst.nl" ];
    };
  };
}