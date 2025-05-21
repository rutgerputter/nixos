{ pkgs, ... }:

{
    programs.ssh = {
        enableAskPassword = true;
        startAgent = true;
    };
}