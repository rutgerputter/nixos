{ pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.sddm.autoNumlock = true;
  services.displayManager.defaultSession = "plasma";
  services.displayManager.autoLogin = {
    enable = false;
  };
  # Disable the X11 windowing system.
  services.xserver.enable = false;

  services.desktopManager.plasma6.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # The background OpenSSH daemon for remote SSH access to this host.
  services.openssh.enable = false;

  # Tailscale VPN
  services.tailscale.enable = true;

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Sunshine
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    # Enable NVENC Support
    package = pkgs.sunshine.override { cudaSupport = true; };
    settings = {
      output_name = 0;
    };
    applications = {
      env = {
        PATH = "$(PATH):$(HOME)/.local/bin";
      };
      apps = [
        {
          name = "Dynamic Desktop";
          prep-cmd = [
            {
              do = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.HDMI-A-1.disable";
              undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.HDMI-A-1.enable";
            }
            {
              do = "sh -c \"${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.$\{SUNSHINE_CLIENT_WIDTH\}x$\{SUNSHINE_CLIENT_HEIGHT\}@$\{SUNSHINE_CLIENT_FPS\}\"";
              undo = "${pkgs.kdePackages.libkscreen}/bin/kscreen-doctor output.DP-1.mode.3440x1440@75";
            }
          ];
          exclude-global-prep-cmd = "false";
          auto-detach = "true";
        }
      ];
    };
  };
}