{ lib, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    acceleration = "cuda";
    loadModels = [
      "mistral:instruct"
    ];
  };
  environment.systemPackages = with pkgs; [
    ollama-cuda
  ];
}