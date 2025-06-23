{ pkgs, ... }:
{
  imports = [
    ./fonts.nix
  ];
  environment.variables = {
    SSH_AUTH_SOCK = "$HOME/.bitwarden-ssh-agent.sock";
    NIXOS_OZONE_WL=1;
  };
  environment.systemPackages = with pkgs; [
    age
    exfat
    exfatprogs
    gcc
    usbutils
    pciutils
    ethtool
    dmidecode
    libva-utils
    lm_sensors
    intel-gpu-tools
    git
    direnv
    nix-search-cli
    nixos-generators
    nil
    nixd
    pavucontrol
    easyeffects
    hunspell
    hunspellDicts.en_US
    hunspellDicts.nl_NL
    python3Full
    htop
    btop
    throttled
    epson-escpr
    epson-escpr2
    epsonscan2
    (hiPrio papirus-icon-theme)
    lshw
    gearlever
    tailscale
    alsa-plugins
    libreoffice
    solaar
    lsd
    fzf
    fastfetch
    tdrop
    python312Packages.pip
    mono
    sdrpp
    haskellPackages.rtlsdr
    rtl-sdr-librtlsdr
    soapyrtlsdr
    retroarch
    google-chrome
    neovim
    scrcpy
    qtscrcpy
    android-studio
    android-tools
    android-udev-rules
    yt-dlp
    parabolic
  ];
}
