{ modulesPath, ... }:

{
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../modules/common-workload/environment
    ../../modules/common-workload/nix
    ../../modules/common-workload/programs
    ../../modules/common-workload/security
    ../../modules/common-workload/users
    ../../modules/common/localization
    ../../modules/common/nixpkgs
    ../../modules/common/programs
  ];

  proxmoxLXC = {
    privileged = true;
    manageNetwork = false;
    manageHostName = false;
  };

  config = {
    boot.isContainer = true;

    console.enable = true;

    systemd.services."getty@" = {
      unitConfig.ConditionPathExists = ["" "/dev/%I"];
    };

    # Supress systemd units that don't work because of LXC
    systemd.suppressedSystemUnits = [
      "dev-mqueue.mount"
      "sys-kernel-debug.mount"
      "sys-fs-fuse-connections.mount"
    ];

    # The background OpenSSH daemon for remote SSH access to this host.
    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.KbdInteractiveAuthentication = false;
    };

    system.stateVersion = "24.11";
  };
}

# To create this LXC, use the commandline or it will fail:
#
# pct create $(pvesh get /cluster/nextid) \
#   --arch amd64 \
#   tn_ssd_containers:vztmpl/nixos-image-lxc-proxmox-25.05.20250606.70c74b0-x86_64-linux.tar.xz \
#   --ostype nixos \
#   --description nixos \
#   --hostname nixos \
#   --net0 name=eth0,bridge=vmbr10,firewall=0,ip=10.0.10.$(pvesh get /cluster/nextid)/24,gw=10.0.10.1 \
#   --net1 name=eth99,bridge=vmbr99,firewall=0,ip=10.0.99.$(pvesh get /cluster/nextid)/24 \
#   --storage tn_ssd_containers \
#   --unprivileged 0 \
#   --features nesting=1 \
#   --cmode tty \
#   --onboot 1