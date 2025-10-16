{ inputs, lib, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
  ];

  nixpkgs.overlays = [
    (final: _: {
      # this allows you to access `pkgs.stable` anywhere in your config
      stable = import inputs.nixpkgs-stable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];
}
