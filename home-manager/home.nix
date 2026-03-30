{ config, pkgs, caelestianix, ... }: {
  imports = [
    caelestianix.homeManagerModules.default
  ];

  home.username = "dairozero";
  home.homeDirectory = "/home/dairozero";
  home.stateVersion = "25.11";

  # Enable Hyprland + Quickshell + Foot theming
  programs.caelestia-dots = {
    enable = true;
    hypr.enable = true;
    term.enable = true;
    foot.enable = true;
    hypr.settings = {
      animations = {
        enabled = false;
      };
    };
  };

  # Extra packages
  home.packages = with pkgs; [
    brave
    pcmanfm-qt
    blender
    audacity
    vlc
    vesktop
    lutris
    mangohud
    gamescope
  ];

  # OBS with NVIDIA CUDA + PipeWire
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

  # programs.zsh.enable = true;
}
