{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages."${system}".default # beta
  ];

  inputs.zen-browser.packages."${system}".default.override {
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # more and more
    };
  }
}