{ config, pkgs, lib, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./modules/default.nix  # your custom modules
  ];

  networking.hostName = "hyprixzero";
  time.timeZone = "Etc/UTC";  # change to your TZ
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.dairozer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.fish;  # Caelestia uses fish
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  programs.hyprland.enable = true;  # base enable (Caelestia will configure it)
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };

  services.flatpak.enable = true;

  system.stateVersion = "25.11";
}
