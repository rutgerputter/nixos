{ lib, ... }:

{

  # Enable QEMU Guest for Proxmox
  services.qemuGuest.enable = lib.mkDefault true;  
  
}
