let
  # put the machine you want to deploy to here from /etc/ssh/ssh_host_ed25519_key.pub
  systems = {
    lxc-janitorr = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ4lOxNJsZCGhTkE0FJDURgxU8STg9SzANXTwQKEZxmg root@lxc-janitorr";
  };
  # put which users should also be able to decrypt the secret
  users = {
    rputter = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXgN/t1XjRbHwcsfihSmx+GiRoPBVU0AzL1o8xTZXNJ rputter@pc-rputter";
  };
  allUsers = builtins.attrValues users;
  allSystems = builtins.attrValues systems;
in {
  "password.age".publicKeys = allUsers ++ allSystems;
}
