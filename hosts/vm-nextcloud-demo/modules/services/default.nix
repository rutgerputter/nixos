{ lib, ... }:

{
  imports = [
    ../../../../modules/common-workload/services
  ];  
  # Enable QEMU Guest for Proxmox
  services.qemuGuest.enable = lib.mkDefault true;  
}
