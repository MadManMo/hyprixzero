{ config, pkgs, lib, inputs, ... }: {
  imports = [
    ./hardware-configuration.nix
    #./pkgs/default.nix
  ];

  #nixpkgs.config.allowUnfree = true;

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
    extraModprobeConfig = '' options v4l2loopback exclusive_caps=1 card_label="Virtual Camera" '';
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
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

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedUDPPorts = [ 49983 ];
  };

  security.rtkit.enable = true;

  services.xserver.enable = false;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;  # optional
  };

  hardware.pulseaudio.enable = false;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde 
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "1";
  };

  programs = {
    fish.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
    };
  };

   programs.nix-ld.enable = true;

   programs.nix-ld.libraries = with pkgs; [
   stdenv.cc.cc.lib
   nss
   nspr
   glib
   gtk3
   gtk2
   pango
   cairo
   atk
   gdk-pixbuf
   fontconfig
   freetype
   harfbuzz
   mesa
   libGL
   libdrm
   libgbm
   libxshmfence
   libxcb
   libx11
   libxcomposite
   libxdamage
   libxext
   libxfixes
   libxrandr
   libxkbcommon
   libxscrnsaver
   libxcb-util
   libxcb-render-util
   libxcb-image
   libxcb-keysyms
   expat
   dbus
   at-spi2-atk
   cups
   udev
   alsa-lib
   ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget

    # Dolphin core
    kdePackages.dolphin

    # Core KDE runtime
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kdegraphics-thumbnailers
    kdePackages.qtsvg
    kdePackages.breeze-icons
    kdePackages.kservice

    # File associations on Hyprland
    kdePackages.plasma-workspace
    kdePackages.dolphin-plugins
    kdePackages.ark

    # General system utils
    shared-mime-info

    # Better search in Dolphin
     kdePackages.baloo
     kdePackages.baloo-widgets

  ];

  environment.etc."xdg/menus/applications.menu".source = "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono      # Your main choice
      nerd-fonts.symbols-only
      nerd-fonts.iosevka-term
      nerd-fonts.iosevka-term-slab
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting.enable = true;
      # hinting.style = "slight";   # or "medium" / "full"
      # subpixel.rgba = "rgb";

      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];   # This is the exact family name
      };
    };
  };

  system.stateVersion = "25.11";
}
