{ pkgs, ... }:

{
  services.flatpak.enable = true;

  # Добавляем Flathub автоматически после rebuild
  systemd.services.flatpak-flathub = {
    description = "Add Flathub Flatpak repository";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    path = [ pkgs.flatpak ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      flatpak remote-add --if-not-exists \
        flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo

      flatpak install --noninteractive --or-update \
        flathub org.vinegarhq.Sober
    '';
  };
}
