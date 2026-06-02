{ config, pkgs, ... }:

{
  # enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.windowManager.bspwm.enable = true;
  services.xserver.displayManager.startx.enable = true;

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:super_space_toggle";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-xapp 
    ];
    config.common.default = "*";
  };
}
