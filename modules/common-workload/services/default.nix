{ ... }:
{
  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}