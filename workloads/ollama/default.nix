{ lib, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    environmentVariables = {
      OLLAMA_KEEP_ALIVE = "-1";
    };
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "10.3.0";
    openFirewall = true;
    acceleration = "rocm";
    host = "[::]";
    loadModels = [
      "gemma3:12b"
      "mistral:instruct"
    ];
    user = "ollama";
  };
  environment.systemPackages = with pkgs; [
    ollama-rocm
    nvtopPackages.amd
  ];
  users.groups."prox-render" = {
    name = "prox-render";
    gid = lib.mkForce 993;
  };

  users.users.ollama.extraGroups = [ "prox-render" ];
}