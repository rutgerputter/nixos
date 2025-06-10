{ ... }:
{
  imports = [
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "rutger@prutser.net";
    defaults.server = "https://acme-staging-v02.api.letsencrypt.org/directory";
  };
}