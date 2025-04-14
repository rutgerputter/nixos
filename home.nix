{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "rputter";
  home.homeDirectory = "/home/rputter";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

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
    };
  };
}