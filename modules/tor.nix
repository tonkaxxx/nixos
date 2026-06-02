{ config, pkgs, lib, ... }:

{
  services.tor = {
    enable = true;
    client.enable = true;
    settings = {
      UseBridges = false;
      Sandbox = false; 
      ClientTransportPlugin = "obfs4 exec ${pkgs.obfs4}/bin/obfs4proxy";
      Bridge = [
        "obfs4 79.76.106.123:5235 525ABD39D207984F6FB14F3EF056F11E4A9B5903 cert=oI6BdjP2ypE9ss4JojT2qlnNJrp9pgHDknMkQ44jgTZiHbAoRFkCykNlBUlm955ZpY5ebg iat-mode=0"
        "obfs4 144.31.122.111:27414 9EFB32E2B50B464EE5155CD0B5373A175066B735 cert=zKf3KK7DYaBIt/gu7qE8dHLF/1M68WPaC1H7JOi7CN0dJbgoneq3aGnx7u5yLsm8jn7/AA iat-mode=0"
      ];
    };
  };

  systemd.services.tor.serviceConfig = {
    # delete restrictions 
    NoNewPrivileges = lib.mkForce false;
    ProtectSystem = lib.mkForce "none";
    ProtectHome = lib.mkForce false;
    ReadOnlyPaths = [ "${pkgs.obfs4}/bin" ];
    PrivateTmp = lib.mkForce false;
  };
}
