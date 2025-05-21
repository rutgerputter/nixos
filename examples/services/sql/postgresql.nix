{ config, ... }:

{
  services.postgresql = {
    enable = true;
    dataDir = "/var/lib/postgresql/${config.services.postgresql.package.psqlSchema}";
    ensureUsers = [
      {
        name = "forgejo";
        ensureDBOwnership = true;
        ensureClauses.login = true;
      }
      {
        name = "superuser";
      }
    ];
    ensureDatabases = [
      "forgejo"
    ];
    settings = {
      port = 5432;
    };
    identMap = ''
      # ArbitraryMapName systemUser DBUser
      superuser_map      root      postgres
      superuser_map      postgres  postgres
      forgejo_map        forgejo   forgejo
      # Let other names login as themselves
      superuser_map      /^(.*)$   \1
    '';
  };
  networking.firewall = {
    # Enable or disable the firewall altogether.
    enable = true;

    # Open ports in the firewall.
    allowedTCPPorts = [ 5432 ];
    allowedUDPPorts = [ ];
  };
}