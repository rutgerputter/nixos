{ ... }:

{
  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
        PasswordAuthentication = true;
        AllowGroups = [ "wheel" ];
        UseDns = true;
        X11Forwarding = false;
        PermitRootLogin = "no";
    };
  };
}