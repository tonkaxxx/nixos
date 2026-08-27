{ config, pkgs, ... }:

{
  # GRUB
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  
  environment.systemPackages = with pkgs; [
    # discord
  ];
}
