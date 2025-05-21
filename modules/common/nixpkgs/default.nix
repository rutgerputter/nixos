{ inputs,lib, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (final: _: {
      # this allows you to access `pkgs.unstable` anywhere in your config
      unstable = import inputs.nixpkgs-unstable {
        inherit (final.stdenv.hostPlatform) system;
        inherit (final) config;
      };
    })
  ];
}
