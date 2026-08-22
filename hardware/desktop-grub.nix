{ config, pkgs, ... }:

{
  # GRUB
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = false; 
    device = "nodev";    
    useOSProber = true;
  };  
}
