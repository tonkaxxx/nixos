{ config, pkgs, ... }:

{
  users.users.root = {
    shell = pkgs.fish;
  };

  users.users.user = {
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "video" "netdev" "lp" "scanner" "docker" ]; # Enable ‘sudo’ for the user.
  };  
}
