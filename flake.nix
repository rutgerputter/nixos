{
  description = "Multi-Machine flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { self, nixpkgs }: {

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          { nix = {  settings.experimental-features = [ "nix-command" "flakes" ]; }; }
          /etc/nixos/configuration.nix
        ];
      };
      nb-rputter = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit (self) inputs outputs; };
        modules = [
          { nix = {  settings.experimental-features = [ "nix-command" "flakes" ]; }; }
          ./hosts/nb-rputter
        ];
      };
      # pc-rputter = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   specialArgs = { inherit (self) inputs outputs; };
      #   modules = [
      #     { nix = {  settings.experimental-features = [ "nix-command" "flakes" ]; }; }
      #     ./hosts/pc-rputter
      #   ];
      # };
    };
  };
}
