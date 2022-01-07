{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    jq 
    git
    wget
    libnotify
    ripgrep
    unzip
    tldr
    pandoc
    pamixer
    screenfetch

    gcc
    rustup
    idris2

    wob
    grim
    slurp
    imv
  ];

  programs.sway.enable = true;
  programs.sway.extraPackages = [];
}
