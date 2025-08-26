{ ... }:
{
  imports = [
    ./mounts.nix
    ./acme.nix
  ];

  services.openldap = {
    enable = true;

    /* enable only secure connections */
    urlList = [ "ldaps:///" ];

    settings = {
      attrs = {
        olcLogLevel = "conns config";

        /* settings for acme ssl */
        olcTLSCACertificateFile = "/var/lib/acme/auth.realiz-it.nl/full.pem";
        olcTLSCertificateFile = "/var/lib/acme/auth.realiz-it.nl/cert.pem";
        olcTLSCertificateKeyFile = "/var/lib/acme/auth.realiz-it.nl/key.pem";
        olcTLSCipherSuite = "HIGH:MEDIUM:+3DES:+RC4:+aNULL";
        olcTLSCRLCheck = "none";
        olcTLSVerifyClient = "never";
        olcTLSProtocolMin = "3.1";
      };

      children = {
        "cn=schema".includes = [
          "${pkgs.openldap}/etc/schema/core.ldif"
          "${pkgs.openldap}/etc/schema/cosine.ldif"
          "${pkgs.openldap}/etc/schema/inetorgperson.ldif"
        ];

        "olcDatabase={1}mdb" = {
          attrs = {
            objectClass = [ "olcDatabaseConfig" "olcMdbConfig" ];

            olcDatabase = "{1}mdb";
            olcDbDirectory = "/var/lib/openldap/data";

            olcSuffix = "dc=realiz-it,dc=nl";

            /* your admin account, do not use writeText on a production system */
            olcRootDN = "cn=admin,dc=realiz-it,dc=nl";
            olcRootPW.path = pkgs.writeText "olcRootPW" "pass";

            olcAccess = [
              /* custom access rules for userPassword attributes */
              ''{0}to attrs=userPassword
                  by self write
                  by anonymous auth
                  by * none''

              /* allow read on anything else */
              ''{1}to *
                  by * read''
            ];
          };

          children = {
            "olcOverlay={2}ppolicy".attrs = {
              objectClass = [ "olcOverlayConfig" "olcPPolicyConfig" "top" ];
              olcOverlay = "{2}ppolicy";
              olcPPolicyHashCleartext = "TRUE";
            };

            "olcOverlay={3}memberof".attrs = {
              objectClass = [ "olcOverlayConfig" "olcMemberOf" "top" ];
              olcOverlay = "{3}memberof";
              olcMemberOfRefInt = "TRUE";
              olcMemberOfDangling = "ignore";
              olcMemberOfGroupOC = "groupOfNames";
              olcMemberOfMemberAD = "member";
              olcMemberOfMemberOfAD = "memberOf";
            };

            "olcOverlay={4}refint".attrs = {
              objectClass = [ "olcOverlayConfig" "olcRefintConfig" "top" ];
              olcOverlay = "{4}refint";
              olcRefintAttribute = "memberof member manager owner";
            };
          };
        };
      };
    };
  };


  /* ensure openldap is launched after certificates are created */
  systemd.services.openldap = {
    wants = [ "acme-auth.realiz-it.nl.service" ];
    after = [ "acme-auth.realiz-it.nl.service" ];
  };

  /* make acme certificates accessible by openldap */
  security.acme.defaults.group = "certs";
  users.groups.certs.members = [ "openldap" ];

}