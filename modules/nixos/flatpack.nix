{ ... }: {
  services.flatpak.enable = true;
  # Optional: auto-add flathub on first rebuild
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
