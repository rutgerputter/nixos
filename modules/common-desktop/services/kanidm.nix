{ pkgs, ... }:
{
  services.kanidm = {
    enableClient = true;
    enablePam = true;
    package = pkgs.kanidm_1_6;
    clientSettings.uri = "https://auth.realiz-it.nl";
    unixSettings = builtins.readFile ./kanidm-unixd.toml;
  };
}