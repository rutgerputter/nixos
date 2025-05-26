{ lib, ... }:

{
  imports = [
    ../../../../modules/common-workload/services
  ];
  services.cloud-init.enable = true;
  # Enable QEMU Guest for Proxmox
  services.qemuGuest.enable = lib.mkDefault true;  
}
