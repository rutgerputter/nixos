{ pkgs, ... }:
{
  users = {
    mutableUsers = true;
    users = {
      rputter = {
        description = "Rutger Putter";
        home = "/home/rputter";
        group = "users";
        createHome = true;
        homeMode = "700";
        hashedPassword = "$y$j9T$CeaswGxiGtazj7NJYdWAT.$TV/wuX8iTVGeKT9OixL36ALWmnN09EpsDC0LtYh6NBB";
        isSystemUser = false;
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel"];
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXgN/t1XjRbHwcsfihSmx+GiRoPBVU0AzL1o8xTZXNJ" ];
#         packages = with pkgs; [
#         ];
      };
    };
  };
}
