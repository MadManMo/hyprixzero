{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./pkgs/default.nix
  ];

  networking.hostName = "hyprixzero";
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.dairozero = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.fish;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
    };
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
    plymouth.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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

  programs.hyprland.enable = true;
  services.pipewire = { enable = true; alsa.enable = true; pulse.enable = true; };

  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.symbols-only
    pkgs.nerd-fonts.iosevka-term
    pkgs.nerd-fonts.iosevka-term-slab
  ];

  services.flatpak.enable = true;

  system.stateVersion = "25.11";
}
