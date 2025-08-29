{ pkgs, ... }:
{
  imports = [ ];

  users = {
    mutableUsers = true;
    users = {
      root = {
        hashedPassword = "!";
      };
    };
  };
}
