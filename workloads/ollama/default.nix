{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;
    rocmOverrideGfx = "10.3.0";
    openFirewall = true;
    acceleration = "rocm";
    loadModels = [
      "gemma3:12b"
      "llama3.1:8b"
      "qwen2.5-coder:7b"
      "deepseek-r1:14b"
      "mistral:7b"
    ];
  };
  environment.systemPackages = with pkgs; [
    ollama-rocm
  ];
}