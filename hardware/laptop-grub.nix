{ config, pkgs, ... }:

{
  services.libinput = {
    enable = true;

    touchpad = {
      accelSpeed = "-0.4";
    };
  };

  networking.hostName = "laptop"; # Define your hostname.

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
