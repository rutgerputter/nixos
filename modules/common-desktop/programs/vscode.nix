{ pkgs, inputs, ... }:
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with inputs.nix-vscode-extensions.extensions.x86_64-linux.vscode-marketplace; [
      # Most extensions should work except packs and should all be downcased
      bierner.markdown-checkbox
      bierner.markdown-emoji
      bierner.markdown-footnotes
      bierner.markdown-mermaid
      bierner.markdown-preview-github-styles
      davidanson.vscode-markdownlint
      henriiik.vscode-sort
      jnoortheen.nix-ide
      kde.breeze
      streetsidesoftware.code-spell-checker
      ybaumes.highlight-trailing-white-spaces
      yzhang.markdown-all-in-one
      ms-vscode.powershell
    ];
  };
}