# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
  
{ config, lib, pkgs, stable-pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix 
      ./garbage-collector.nix 
      ./tor.nix 
      ./build-res-limits.nix 
      ./x11.nix
      ./users.nix
      ./happ-nixos/happ-module.nix 
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true; # for proprietary apps

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

  networking.hostName = "nixos"; # Define your hostname.

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  # locales
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
  };  

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.samsung-unified-linux-driver ];
  };
  # enable printer scanner
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.samsung-unified-linux-driver ];
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  programs.throne = {
    enable = true;
    tunMode.enable = true; 
  };

  programs.fish.enable = true;
  programs.firefox.enable = true;
  services.envfs.enable = true; # for /bin/bash
  programs.steam.enable = true;
  # programs.happ.enable = true;
  # services.throne.enable = true;
  # programs.throne.tunMode.enable = true;
  programs.dconf.enable = true; # so apps can see dark theme

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    wget
    fastfetch
    fish
    vim
    micro
    bat
    duf   
    bash
    tree
    radeontop
    ntfs3g
    pciutils
    bibata-cursors
    xclip
    scrot # screenshots
    bash
    git
    tor
    zapret
    btop
    obfs4
    wineWow64Packages.unstable
    winetricks
    ghostscript # for pdf dpwnscaling

    kubectl
    helm
    docker
    python3
    python3Packages.pip
    python312Packages.flask
    python312Packages.tkinter

    firefox
    chromium
    flameshot
    kitty
    stable-pkgs.telegram-desktop
    obsidian
    easyeffects
    pavucontrol
    vscode    
    # throne  
    thunar
    copyq
    rnote
    discord
    vesktop
    obs-studio
    stable-pkgs.libreoffice
    alacritty
    tor-browser
    thunar
    mpv
    stable-pkgs.qbittorrent
    tetris

    bspwm
    sxhkd
    polybar
    dmenu
    feh
    picom
    xinit
    xrandr
    xrdb
    rofi
    dunst
    libnotify
    ipset 
    iptables
  ];

  fonts.packages = with pkgs; [
    freefont_ttf
    material-design-icons
    unifont
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    GTK_THEME = "Adwaita:dark";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
