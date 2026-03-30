{ config, pkgs, caelestianix, ... }: {
  imports = [
    caelestianix.homeManagerModules.default
  ];

  home.username = "dairozero";
  home.homeDirectory = "/home/dairozero";
  home.stateVersion = "25.05";

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
    blender
    obs-studio
    obs-studio-plugins.obs-vaapi
    obs-studio-plugins.obs-websocket
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.input-overlay
    obs-studio-plugins.obs-aitum-multistream
    obs-studio-plugins.obs-retro-effects
    obs-studio-plugins.obs-advanced-masks
    obs-studio-plugins.obs-stroke-glow-shadow
    pcmanfm-qt
    audacity
    vlc
    vesktop
  ];

  # OBS with NVIDIA CUDA + PipeWire
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-backgroundremoval
    ];
  };

  # programs.zsh.enable = true;
}
