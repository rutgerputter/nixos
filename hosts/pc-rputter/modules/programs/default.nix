{ ... }:

{
  programs = {
    git = {
      enable = true;
      lfs = {
          enable = true;
      };
      prompt = {
          enable = false;
      };
    };

    virt-manager.enable = true;
    kdeconnect.enable = true;

    steam = {
      enable = true;
      localNetworkGameTransfers = {
        openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      };
      remotePlay = {
        openFirewall = true; # Open ports in the firewall for Steam Remote Play
      };
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;

    # Zsh configuration
	  zsh = {
    	enable = true;
	  	enableCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git"];
        theme = "agnoster";
      };

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        update = "cd ~/Git/nixos; sudo nixos-rebuild switch --flake .#pc-rputter";
      };

      histSize = 10000;
      histFile = "$HOME/.zsh_history";
      promptInit = ''
        # Set-up icons for files/directories in terminal using lsd
        alias ls='lsd'
        alias l='ls -l'
        alias la='ls -a'
        alias lla='ls -la'
        alias lt='ls --tree'

        source <(fzf --zsh);
        HISTFILE=~/.zsh_history;
        HISTSIZE=10000;
        SAVEHIST=10000;
        setopt appendhistory;
        '';
    };

    # Install firefox system wide.
    firefox = {
      enable = true;
      languagePacks = [ "en-US" "en-GB" "nl" ];

      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = false;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always"; # options: "always", "never", or "newtab"
        DisplayMenuBar = "default-off"; # options: "always", "default-off", "default-on", or "never"
        SearchBar = "unified"; # options: "separate", or "unified"

        /* ---- EXTENSIONS ---- */
        # Check about:support for extension/add-on ID strings.
        # Valid strings for installation_mode are "allowed", "blocked",
        # "force_installed" and "normal_installed".
        ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # Startpage Search:
          "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/startpage-private-search/latest.xpi";
              installation_mode = "force_installed";
          };
          # firefox Multi-Account Containers:
          "@testpilot-containers" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/multi-account-containers/latest.xpi";
              installation_mode = "force_installed";
          };
          # plasma Integration:
          "plasma-browser-integration@kde.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/plasma-integration/latest.xpi";
              installation_mode = "force_installed";
          };
          # Bitwarden:
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
              installation_mode = "force_installed";
          };
          # I still don't care about cookies:
          "idcac-pub@guus.ninja" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/istilldontcareaboutcookies/latest.xpi";
              installation_mode = "force_installed";
          };
          # enhanced-h264ify:
          "{9a41dee2-b924-4161-a971-7fb35c053a4a}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/latest.xpi";
              installation_mode = "force_installed";
          };
          # SponsorBlock for YouTube - Skip Sponsorships:
          "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
          };
          # Breeze Dark:
          "{4e507435-d65f-4467-a2c0-16dbae24f288}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/breezedarktheme/latest.xpi";
              installation_mode = "force_installed";
          };                
        };
      };
    };
  };
}