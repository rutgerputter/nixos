{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
    git
    direnv
    nix-search-cli
    python3Full
    htop
    yakuake
    throttled
    epson-escpr
    epson-escpr2
    epsonscan2
    (hiPrio papirus-icon-theme)
    lshw
    kdePackages.partitionmanager
    kdePackages.kate
    kdePackages.filelight
    kdePackages.kcalc
    brave
    android-tools
    gearlever
    tailscale
    ktailctl
    alsa-plugins
    libreoffice
    solaar
    lsd
    fzf
    fastfetch
    kitty
    tdrop
  ];
  
  # FONTS
  fonts.packages = with pkgs; [
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    (nerdfonts.override {fonts = ["JetBrainsMono"];}) # stable banch
    (nerdfonts.override {fonts = ["FantasqueSansMono"];}) # stable banch
  ];
}
