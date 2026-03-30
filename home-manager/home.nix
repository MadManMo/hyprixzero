{ config, pkgs, inputs, ... }: {
  imports = [];

  home.username = "dairozero";
  home.homeDirectory = "/home/dairozero";
  home.stateVersion = "25.11";

  wayland.windowManager.hyprland.systemd.enable = false;

  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
  };

  # === Gaming ===
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    remotePlay.openFirewall = true;
  };

  programs.gamemode.enable = true;

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
    neovim
    tmux
    yazi
    unzip
    yt-dlp

    # === Qt6 / Theming & File Management ===
    pcmanfm-qt
    qt6ct
    qt5ct
    libsForQt6.qt6-wayland
    libsForQt5.qt5-wayland
    kvantum

    # === Wayland / Hyprland Utilities ===
    awww 
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

    # === Monitoring ===
    nvtop
    pwvucontrol

    # === Media & Creative ===
    audacity
    blender
    ffmpeg
    reaper
    vlc

    # === Browsing / Chat ===
    brave
    vesktop

    # === OCR ===
    tesseract
    tesseract-data-eng
    tesseract-data-spa

    # === Gaming Tools ===
    mangohud
    gamescope
    lutris
    protonup-qt

  ];

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    # QT_STYLE_OVERRIDE = "kvantum";
  };

}
