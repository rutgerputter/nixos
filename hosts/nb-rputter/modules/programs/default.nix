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
        DisableFirefoxAccounts = false;
        DisableAccounts = false;
        DisableFirefoxScreenshots = false;
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
            "*".installation_mode = "allowed"; # blocks all addons except the ones specified below
            # ecosia Search:
            "{d04b0b40-3dab-4f0b-97a6-04ec3eddbfb0}" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/ecosia-the-green-search/latest.xpi";
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
            # proton VPN:
            "vpn@proton.ch" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/proton-vpn-firefox-extension/latest.xpi";
                installation_mode = "force_installed";
            };
            # keepassxc browser:
            "keepassxc-browser@keepassxc.org" = {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
                installation_mode = "force_installed";
            };
        };

        /* ---- PREFERENCES ---- */
        # Check about:config for options.
        Preferences = {
            "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
            "extensions.pocket.enabled" = false;
            "extensions.screenshots.disabled" = false;
            "browser.topsites.contile.enabled" = false;
            "browser.formfill.enable" = false;
            "browser.search.suggest.enabled" = true;
            "browser.search.suggest.enabled.private" = false;
            "browser.urlbar.suggest.searches" = true;
            "browser.urlbar.showSearchSuggestionsFirst" = false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.snippets" = false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;
            "browser.newtabpage.activity-stream.system.showSponsored" = false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;
            "signon.autofillForms" = false;
        };
      };
    };
  };
}