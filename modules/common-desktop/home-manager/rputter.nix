# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ ... }: {
  # You can import other home-manager modules here
  imports = [ ];

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
      profiles.default.extensions = with pkgs.vscode-extensions; [
        kde.breeze
        bat67.markdown-extension-pack
        pinage404.nix-extension-pack
        streetsidesoftware.code-spell-checker
        ybaumes.highlight-trailing-white-spaces
        henriiik.vscode-sort
      ];
    };    
  };



  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
