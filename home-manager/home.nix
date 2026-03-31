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
    '';

    shellAliases = {
      ls = "eza -la --icons";
      vim = "nvim";
      update = "sudo nixos-rebuild switch --flake .#hyprixzero";
      upgrade = "sudo nixos-rebuild switch --flake .#hyprixzero && home-manager switch --flake .#dairozero";
    };
  };

  # === Quickshell ===
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.system}.default;
  };

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
    eza

    # === Qt6 / Theming & File Management ===
    pcmanfm-qt
    qt6Packages.qt6ct
    qtwayland
    kvantum
    hyprland-qt-support

    # === Wayland / Hyprland Utilities ===
    swww
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

    # Optional
    # imv
  ];

  # Qt theming
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    # QT_STYLE_OVERRIDE = "kvantum";
  };

}
