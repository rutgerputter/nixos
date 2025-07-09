{ ... }:
{
  services.gitwatch."mkdocs-tcsnlps" = {
    enable = true;
    remote = "https://forge.intern.prutser.net/rutgerputter/mkdocs-tcsnlps.git";
    path = "/var/lib/private/mkdocs";
    user = "mkdocs";
  };
}