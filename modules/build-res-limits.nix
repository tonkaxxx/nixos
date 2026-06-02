{ config, pkgs, ... }:

{
  nix.settings = {
    max-jobs = 7;
    cores = 7;
  };
}
