{ config, pkgs, caelestianix, ... }: {
  imports = [
    caelestianix.homeManagerModules.default
  ];

  home.username = "dairozero";
  home.homeDirectory = "/home/dairozero";
  home.stateVersion = "25.11";

  programs.caelestia-dots = enable = true;

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
