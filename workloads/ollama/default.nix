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
      "deepseek-r1:14b"
      "qwen3:8b"
      "llama3.2-vision:11b"
      "gemma2:9b"
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
