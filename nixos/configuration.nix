# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    ./home-manager.nix

    ./boot.nix
    ./nvidia.nix
    ./programs.nix
    ./services.nix
    ./syspackages.nix
    ./userpackages.nix
  ];
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-ca4832e4-ab65-4015-a638-6291f324e999".device = "/dev/disk/by-uuid/ca4832e4-ab65-4015-a638-6291f324e999";
  
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      auto-optimise-store = true;
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    optimise = {
      automatic = true;
      dates = [ "12:00" ]; # Optional; allows customizing optimisation schedule
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };    
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # FIXME: Add the rest of your current configuration

  # zram
  zramSwap = {
	  enable = true;
	  priority = 100;
	  memoryPercent = 30;
	  swapDevices = 1;
    algorithm = "zstd";
  };

  networking.hostName = "nb-rputter";
  networking.networkmanager.enable = true;  

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = false;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;          
        };
      };
    };
    extraConfig.pipewire-pulse = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;          
        };
      };
    };
    extraConfig.client = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;          
        };
      };
    };
    extraConfig.client-rt = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;          
        };
      };
    };
    wireplumber.extraConfig = {
      "10-upmix" = {
        "stream.properties" = {
          "channelmix.upmix" = true;
          "channelmix.upmix-method" = "simple";  # or "psd" if you prefer
          "channelmix.lfe-cutoff" = 150;
          "channelmix.fc-cutoff" = 12000;
          "channelmix.rear-delay" = 12.0;          
        };
      };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  hardware.cpu.intel.sgx.provision.enable = true;

  services.hardware.bolt.enable = true;
  hardware.logitech.wireless.enable = true;

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  services.fwupd.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  environment.etc = {
    # fix for cause #1
    "alsa/conf.d/60-a52-encoder.conf".source =
      pkgs.alsa-plugins + "/etc/alsa/conf.d/60-a52-encoder.conf";

    # fix for cause #2
    "alsa/conf.d/59-a52-lib.conf".text = ''
      pcm_type.a52 {
        lib "${pkgs.alsa-plugins}/lib/alsa-lib/libasound_module_pcm_a52.so"
      }
    '';
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  users.users = {
    rputter = {
      isNormalUser = true;
      description = "Rutger Putter";
      extraGroups = [ "networkmanager" "wheel" "gamemode" "libvirtd"];
      shell = pkgs.zsh;
    };
  };

  system.autoUpgrade.enable  = true;
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
