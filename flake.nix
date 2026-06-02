{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs = { self, nixpkgs, zapret-discord-youtube, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/configuration.nix
        zapret-discord-youtube.nixosModules.withTestTools
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT)";
            gameFilter = "all";
            listGeneral = [ "example.com" "test.org" "mysite.net" ];
            listExclude = [ "ubisoft.com" "origin.com" ];
            ipsetAll = [ "192.168.88.0/24" ];
            ipsetExclude = [ "203.0.113.0/24" ];
          };
        }
      ];
    };
  };
}
