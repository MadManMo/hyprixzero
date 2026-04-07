{ config, pkgs, inputs, ... }: {
  imports = [];

  home.username = "dairozero";
  home.homeDirectory = "/home/dairozero";
  home.stateVersion = "25.11";

  # Important for UWSM
  wayland.windowManager.hyprland.systemd.enable = false;

  # === Shell ===
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting          # Disable default greeting
      # Auto-start Hyprland via UWSM only on tty1
      if status is-interactive
        if test -z "$WAYLAND_DISPLAY" -a "$XDG_VTNR" = 1
          if command -q uwsm && uwsm check may-start
            exec uwsm start -eD Hyprland hyprland.desktop
          end
        end
      end
    '';

    shellAliases = {
      ls = "eza -la --icons";
      vim = "nvim";
      update = "sudo nixos-rebuild switch --flake .#hyprixzero";
      upgrade = "sudo nixos-rebuild switch --flake .#hyprixzero";
    };
  };

  # === Cursor ===
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";     # Black theme (rounded)
    #name = "Bibata-Original-Classic"; # Black theme (sharp)
    size = 24;
    hyprcursor = {
      enable = true;
    };
  };

  # === Noctalia Shell ===
  imports = [
    inputs.noctalia.homeModules.default
    ./noctalia.nix
  ];

  # === OBS Studio ===
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-backgroundremoval
      obs-vkcapture
      obs-advanced-masks
      obs-stroke-glow-shadow
      input-overlay
      obs-aitum-multistream
      obs-gstreamer
      obs-retro-effects
    ];
  };

  # === Home Packages ===
  home.packages = with pkgs; [

    # === Terminal / CLI ===
    fastfetch
    foot
    kitty
    neovim
    tmux
    yazi
    unzip
    yt-dlp
    eza
    btop

    # === Qt6 / Theming & File Management ===
    kdePackages.qt6ct                
    kdePackages.plasma-integration   
    kdePackages.qtwayland 
    qt6Packages.qt6ct
    libsForQt5.qt5.qtwayland
    hyprland-qt-support
    gnome-themes-extra
    nwg-look

    # === Wayland / Hyprland Utilities ===
    swww
    wallust
    brightnessctl
    cliphist
    ddcutil
    grim
    gpu-screen-recorder
    hyprsunset
    imagemagick
    playerctl
    slurp
    swappy
    wl-clipboard
    pipewire
    wireplumber
    networkmanager
    socat

    # === Monitoring ===
    pwvucontrol

    # === Media & Creative ===
    audacity
    reaper
    blender
    ffmpeg
    vlc
    kdePackages.kdenlive

    # === Browsing / Chat ===
    brave
    vesktop

    # === Gaming Tools ===
    mangohud
    gamescope
    lutris
    protonup-qt

    # Optional
    # imv
    rmpc
  ];

  # Qt theming
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
  };

}
