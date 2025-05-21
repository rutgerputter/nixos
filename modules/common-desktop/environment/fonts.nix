{ pkgs, ... }:
{
  # FONTS
  fonts.packages = with pkgs; [
    inter
    noto-fonts
    fira-code
    noto-fonts-cjk-sans
    jetbrains-mono
    font-awesome
    terminus_font
    victor-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.fantasque-sans-mono
  ];
}
