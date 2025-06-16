# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ pkgs, inputs, ... }: {
  # You can import other home-manager modules here
  imports = [
  ];

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userEmail = "rutger@prutser.net";
      userName = "Rutger Putter";
    };
    mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        control = "mangohud";
        legacy_layout = 0;
        horizontal = true;
        battery = true;
        gpu_stats = true;
        gpu_temp = true;
        cpu_stats = true;
        cpu_temp = true;
        cpu_mhz = true;
        vram = true;
        ram = true;
        fps = true;
        frametime = 0;
        hud_no_margin = true;
        table_columns = 14;
        frame_timing = 1;
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default.extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
        # Most extensions should work except packs and should all be downcased
        bierner.markdown-checkbox
        bierner.markdown-emoji
        bierner.markdown-footnotes
        bierner.markdown-mermaid
        bierner.markdown-preview-github-styles
        davidanson.vscode-markdownlint
        henriiik.vscode-sort
        jnoortheen.nix-ide
        kde.breeze
        streetsidesoftware.code-spell-checker
        ybaumes.highlight-trailing-white-spaces
        yzhang.markdown-all-in-one
      ];
    };
  };

  xdg.configFile."autostart/gnome-keyring-ssh.desktop" = {
    text = ''
      [Desktop Entry]
      Type=Application
      Name=SSH Key Agent
      Comment=GNOME Keyring: SSH Agent
      Exec=/run/wrappers/bin/gnome-keyring-daemon --start --components=ssh
      OnlyShowIn=GNOME;Unity;MATE;
      X-GNOME-Autostart-Phase=PreDisplayServer
      X-GNOME-AutoRestart=false
      X-GNOME-Autostart-Notify=true
      Hidden=true
    '';
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
