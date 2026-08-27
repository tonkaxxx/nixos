{
  description = "nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    codex-cli.url = "github:sadjow/codex-cli-nix";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    codex-cli,
    zapret-discord-youtube,
    ...
  }@inputs:
  let
    commonModules = [
      ./modules/configuration.nix

      {
        _module.args.stable-pkgs = import nixpkgs-stable {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };

        environment.systemPackages = [
          codex-cli.packages."x86_64-linux".default
        ];
      }

      zapret-discord-youtube.nixosModules.withTestTools

      {
        services.zapret-discord-youtube = {
          enable = true;
          configName = "general(ALT)";
          gameFilter = "all";
        };
      }
    ];
  in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ [
          ./hardware/desktop-hard.nix
          ./hardware/desktop-grub.nix
        ];
      };

      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = commonModules ++ [
          ./hardware/laptop-hard.nix
          ./hardware/laptop-grub.nix
        ];
      };
    };
  };
}
