{ ... }:
{
  imports = [
  ];

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
  };
}