{ pkgs, config, ... }: {

  imports = [
    ../common/podman
  ];
  services.gitea-actions-runner = {
    package = pkgs.forgejo-actions-runner;
    instances.default = {
      enable = true;
      name = "lxc-forge-runner";
      url = "https://forge.intern.prutser.net";
      # Obtaining the path to the runner token file may differ
      # tokenFile should be in format TOKEN=<secret>, since it's EnvironmentFile for systemd
      tokenFile = config.age.secrets.forgejo-runner-token.path;
      labels = [
        "ubuntu-latest:docker://node:16-bullseye"
        "ubuntu-22.04:docker://node:16-bullseye"
        # provide native execution on the host:
        "native:host"
      ];
    };
  };

  age.secrets.forgejo-runner-token = {
    file = ../../secrets/forgejo-runner-token.age;
  };
}