{ config, pkgs, caelestianix, ... }: {
  imports = [
    caelestianix.homeManagerModules.default
  ];

  home.username = "dairozer";
  home.homeDirectory = "/home/dairozer";
  home.stateVersion = "25.05";

  # Enable Hyprland + Quickshell + Termina theming
  programs.caelestia-dots = {
    enable = true;
    hypr.enable = true;        # enables Hyprland config from Caelestia
    term.enable = true;        # Foot + Fish + Starship
    foot.enable = true;
    hypr.settings = {
      animations = {
        enabled = false;  # little to no animations as you wanted
      };
    };
  };

  # Extra packages
  home.packages = with pkgs; [
    blender
    obs-studio  # native with CUDA support (see below)
    pcmanfm-qt  # Qt file browser (theming-friendly)
    # more suggestions: kdenlive (video editing), gimp, audacity, vlc, etc.
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

}
