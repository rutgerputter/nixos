{ ... }:
{
  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    settings.LogLevel = "DEBUG";
    # require public key authentication for better security
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}