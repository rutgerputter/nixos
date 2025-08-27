{ ... }:
{
  services.kanidm = {
    enableClient = true;
    clientSettings.uri = "https://auth.realiz-it.nl";
  };
}