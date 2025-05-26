{ ... }:

{
  imports = [
    ../../../../modules/common-workload/nix
  ];
  
  # Allow remote updates with flakes and non-root users
  nix.settings.trusted-users = [ "root" "@wheel" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
}
